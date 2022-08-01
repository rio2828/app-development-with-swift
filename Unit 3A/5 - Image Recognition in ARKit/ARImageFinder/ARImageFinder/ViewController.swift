//
//  ViewController.swift
//  ARImageFinder
//
//  Created by 김태현 on 2022/07/27.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        // let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        // sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else { return }
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = referenceImages

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    var waitRemoveAction: SCNAction {
        return SCNAction.sequence([.wait(duration: 5.0), .fadeOut(duration: 2.0), .removeFromParentNode()])
    }
    func nodeAdded(_ node: SCNNode, for imageAnchor: ARImageAnchor) {
        let referenceImage = imageAnchor.referenceImage
        print("\(String(describing: referenceImage.name)) found")
        
        let plane = SCNPlane(width: referenceImage.physicalSize.width, height: referenceImage.physicalSize.height)
        
        plane.firstMaterial?.diffuse.contents = UIColor.blue
        let planeNode = SCNNode(geometry: plane)
        planeNode.eulerAngles.x = -Float.pi / 2
        planeNode.opacity = 0.25
        node.addChildNode(planeNode)
        planeNode.runAction(waitRemoveAction) 
        
    }
    
    func nodeAdded(_ node: SCNNode, for planeAnchor: ARPlaneAnchor) {
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        switch anchor {
        case let imageAnchor as ARImageAnchor :
            nodeAdded(node, for: imageAnchor)
        case let planeAnchor as  ARPlaneAnchor :
            nodeAdded(node, for: planeAnchor)
        default :
            print("An anchor was discovered, but it is not for planes or images")
        }
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
