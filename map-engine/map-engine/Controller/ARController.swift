//
//  ARController.swift
//  map-engine
//
//  Created by Lauren Go on 2019/04/18.
//  Copyright © 2019 go-lauren. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ARController: UIViewController, ARSCNViewDelegate {
    
    var sceneView: ARSCNView!
    var map: Graph = Graph(width: 100, height: 50)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        map.fill()
        
        self.view.backgroundColor = .white
        
        self.sceneView = ARSCNView()
        
        self.view.addSubview(sceneView)
        
        sceneView.frame = self.view.bounds
        
//        sceneView.pinEdges(to: self.view)
//        sceneView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Debugging Features
        sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin,
                                  ARSCNDebugOptions.showFeaturePoints]
        sceneView.autoenablesDefaultLighting = true
        
        addTapGestureToSceneView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
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
    
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {

        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        
        let width = CGFloat(planeAnchor.extent.x)
        let height = CGFloat(planeAnchor.extent.z)
        let plane = SCNPlane(width: width, height: height)
        
        plane.materials.first?.diffuse.contents = UIColor.red
        
        let planeNode = SCNNode(geometry: plane)
        
        let x = CGFloat(planeAnchor.center.x)
        let y = CGFloat(planeAnchor.center.y)
        let z = CGFloat(planeAnchor.center.z)
        planeNode.position = SCNVector3(x,y,z)
        planeNode.eulerAngles.x = -.pi / 2
        
        node.addChildNode(planeNode)
    }
    
//    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
//        // 1
//        guard let planeAnchor = anchor as?  ARPlaneAnchor,
//            let planeNode = node.childNodes.first,
//            let plane = planeNode.geometry as? SCNPlane
//            else { return }
//
//        // 2
//        let width = CGFloat(planeAnchor.extent.x)
//        let height = CGFloat(planeAnchor.extent.z)
//        plane.width = width
//        plane.height = height
//
//        // 3
//        let x = CGFloat(planeAnchor.center.x)
//        let y = CGFloat(planeAnchor.center.y)
//        let z = CGFloat(planeAnchor.center.z)
//        planeNode.position = SCNVector3(x, y, z)
//    }
    
    
    func addTapGestureToSceneView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ARController.renderMap(withGestureRecognizer:)))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func renderMap(withGestureRecognizer recognizer: UIGestureRecognizer) {
        let tapLocation = recognizer.location(in: sceneView)
        guard let result = sceneView.hitTest(tapLocation, options: nil).first else { return }
        
        let tappedNode: SCNNode = result.node
            if let geometry = tappedNode.geometry as? SCNPlane {
                // obj is a string array. Do something with stringArray
                let dimension: CGFloat = min(geometry.width / CGFloat(map.w) , geometry.height / CGFloat(map.h))
                let outside = SCNPlane(width: dimension, height: dimension)
                let inside =  SCNPlane(width: dimension, height: dimension)
                let wall = SCNPlane(width: dimension, height: dimension)
                print(dimension)
                outside.materials.first?.diffuse.contents = UIColor.red
                inside.materials.first?.diffuse.contents = UIColor.blue
                wall.materials.first?.diffuse.contents = UIColor.white
                
                var tiles = map.generate()
                for i in 0..<tiles.count {
                    for j in 0..<tiles[0].count {
                        let floor = SCNNode()
                        floor.position = SCNVector3(CGFloat(i) * dimension - 0.5 * geometry.width, CGFloat(j) * dimension - 0.5 * geometry.height, 0.1)
                        switch (tiles[i][j]) {
                            case Graph.Tile.Floor:
                                floor.geometry = inside
                            case Graph.Tile.Outside:
                                floor.geometry = outside
                            case Graph.Tile.Wall:
                                floor.geometry = wall
                        }
                        tappedNode.addChildNode(floor)
                        geometry.materials.first?.diffuse.contents = UIColor.black
//                        sceneView.scene.rootNode.addChildNode(floor)
                    }
                }
            }

    }
    
    @objc func addShipToSceneView(withGestureRecognizer recognizer: UIGestureRecognizer) {
        let tapLocation = recognizer.location(in: sceneView)
        let hitTestResults = sceneView.hitTest(tapLocation, types: .existingPlaneUsingExtent)
        
        guard let hitTestResult = hitTestResults.first else { return }
        let translation = hitTestResult.worldTransform.columns.3
        let x = translation.x
        let y = translation.y
        let z = translation.z
        
        let shipNode = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.0))
    
        
        
        shipNode.position = SCNVector3(x,y,z)
        sceneView.scene.rootNode.addChildNode(shipNode)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ARSCNView {
    func sceneHitTest(_ point: CGPoint, options: [SCNHitTestOption : Any]? = nil) -> [SCNHitTestResult] {
        return super.hitTest(point, options: options)
    }
}
