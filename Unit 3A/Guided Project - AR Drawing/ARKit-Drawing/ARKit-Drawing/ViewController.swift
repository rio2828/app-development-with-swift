import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    enum ObjectPlacementMode {
        case freeform, plane, image
    }
    
    var objectMode: ObjectPlacementMode = .freeform {
        didSet {
            reloadConfiguration()
        }
    }
    
    var selectedNode: SCNNode?
    
    var placedNode = [SCNNode]()
    var planeNode = [SCNNode]()
    
    var showPlaneOverlay = false {
        didSet {
            for node in planeNode {
                node.isHidden = !showPlaneOverlay
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        sceneView.autoenablesDefaultLighting = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadConfiguration()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }

    func reloadConfiguration(removeAnchors: Bool = false) {
        configuration.planeDetection = [.horizontal, .vertical]
        configuration.detectionImages = (objectMode == .image) ? ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) : nil
        
        let options: ARSession.RunOptions
        if removeAnchors {
            options = [.removeExistingAnchors]
            for node in planeNode {
                node.removeFromParentNode()
            }
            planeNode.removeAll()
            placedNode.map{$0.removeFromParentNode()}
            placedNode.removeAll()
        } else {
            options = []
        }
        sceneView.session.run(configuration, options: options)
    }
    
    
    @IBAction func changeObjectMode(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            objectMode = .freeform
        case 1:
            objectMode = .plane
        case 2:
            objectMode = .image
        default:
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showOptions" {
            let optionsViewController = segue.destination as! OptionsContainerViewController
            optionsViewController.delegate = self
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        guard let node = selectedNode, let touch = touches.first else { return }
        
        switch objectMode {
        case .freeform:
            addNodeInFront(node)
        case .plane:
            let touchPoint = touch.location(in: sceneView)
            addNode(node, toPlaneUsingPoint: touchPoint)
        case .image:
            break
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        
        guard objectMode == .plane, let node = selectedNode, let touch = touches.first, let lastTouchPoint = lastObjectPlacedPoint else { return }
        
        let newTouchPoint = touch.location(in: sceneView)
        let distance = sqrt(pow((newTouchPoint.x - lastTouchPoint.x), 2.0) + pow((newTouchPoint.y - lastTouchPoint.y), 2.0))
        print("Moved, locX = \(newTouchPoint.x), locY = \(newTouchPoint.y)")
        
        if distance > touchDistanceThresold {
            addNode(node, toPlaneUsingPoint: newTouchPoint)
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        lastObjectPlacedPoint = nil
    }
    
    func addNodeInFront(_ node: SCNNode) {
        guard let currentFrame = sceneView.session.currentFrame else { return }
        
        var translation = matrix_identity_float4x4
        translation.columns.3.z = -0.2
        node.simdTransform = matrix_multiply(currentFrame.camera.transform, translation)
        
        addNodeToSceneRoot(node)
        
    }
    
    func addNodeToSceneRoot(_ node: SCNNode) {
        let cloneNode = node.clone()
        sceneView.scene.rootNode.addChildNode(cloneNode)
        placedNode.append(cloneNode)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if let imageAnchor = anchor as? ARImageAnchor {
            nodeAdded(node, for: imageAnchor)
        } else if let planeAnchor = anchor as? ARPlaneAnchor {
            nodeAdded(node, for: planeAnchor)
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor,
        let planeNode = node.childNodes.first,
        let plane = planeNode.geometry as? SCNPlane else { return }
        
        planeNode.position = SCNVector3(planeAnchor.center.x, 0, planeAnchor.center.z)
        plane.width = CGFloat(planeAnchor.extent.x)
        plane.height = CGFloat(planeAnchor.extent.z)
    }
    
    func nodeAdded(_ node: SCNNode, for anchor: ARPlaneAnchor) {
        let floor = createFloor(planeAnchor: anchor)
        floor.isHidden = !showPlaneOverlay
        
        node.addChildNode(floor)
        planeNode.append(floor)
        
    }
    
    func nodeAdded(_ node: SCNNode, for anchor: ARImageAnchor) {
        if let selectedNode = selectedNode {
            addNode(selectedNode, toImageUsingParentNode: node)
        }
    }
    
    
    func addNode(_ node: SCNNode, toImageUsingParentNode parentNode: SCNNode) {
        let cloneNode = node.clone()
        parentNode.addChildNode(cloneNode)
        placedNode.append(cloneNode)
    }
    
    var lastObjectPlacedPoint: CGPoint?
    let touchDistanceThresold: CGFloat = 40.0
    
    func addNode(_ node: SCNNode, toPlaneUsingPoint point: CGPoint) {
        let results = sceneView.hitTest(point, types: [ .existingPlaneUsingExtent])
        
        if let match = results.first {
            let t = match.worldTransform
            node.position = SCNVector3(t.columns.3.x, t.columns.3.y, t.columns.3.z)
            
            addNodeToSceneRoot(node)
            lastObjectPlacedPoint = point
        }
        
    }
    
    func createFloor(planeAnchor:ARPlaneAnchor) -> SCNNode {
        let node = SCNNode()
        
        let geometry = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
        
        node.geometry = geometry
        
        node.eulerAngles.x = -.pi/2
        node.opacity = 0.25
        
        return node
    }

}

extension ViewController: OptionsViewControllerDelegate {
    
    
    func objectSelected(node: SCNNode) {
        dismiss(animated: true, completion: nil)
        selectedNode = node
    }
    
    func togglePlaneVisualization() {
        dismiss(animated: true, completion: nil)
        showPlaneOverlay = !showPlaneOverlay
    }
    
    func undoLastObject() {
        if let lastNode = planeNode.last {
            lastNode.removeFromParentNode()
        }
    }
    
    func resetScene() {
        dismiss(animated: true, completion: nil)
        reloadConfiguration(removeAnchors: true)
    }
}
