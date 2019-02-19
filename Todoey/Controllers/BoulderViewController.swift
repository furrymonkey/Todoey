//
//  BoulderViewController.swift
//  Todoey
//
//  Created by Apple on 19/02/2019.
//  Copyright © 2019 Jamie King. All rights reserved.
//

import UIKit
import SceneKit

class BoulderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let scnView = SCNView(frame: self.view.frame)
        self.view.addSubview(scnView)
        
        let scene = SCNScene()
        scnView.scene = scene
        
        
        let cube = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0.02)
        let cubeNode = SCNNode(geometry: cube)
        
        let redMaterial = SCNMaterial()
        redMaterial.diffuse.contents = UIColor.red
        cube.materials = [redMaterial]
        
        let plane = SCNPlane(width: 50.0, height: 50.0)
        let planeNode = SCNNode(geometry: plane)
        planeNode.eulerAngles = SCNVector3(GLKMathDegreesToRadians(-90), 0, 0)
        planeNode.position = SCNVector3(0, -0.5, 0)
        
        let greenMaterial = SCNMaterial()
        greenMaterial.diffuse.contents = UIColor.green
        plane.materials = [greenMaterial]
        
        let camera = SCNCamera()
        let cameraNode = SCNNode()
        
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(x: -3.0,y: 3.0,z: 3.0)
        
        let light = SCNLight()
        light.type = SCNLight.LightType.omni
        let lightNode = SCNNode()
        
        lightNode.light = light
        lightNode.position = SCNVector3(x: 1.5,y: 1.5,z: 1.5)
        
        scene.rootNode.addChildNode(cameraNode)
        scene.rootNode.addChildNode(lightNode)
        scene.rootNode.addChildNode(cubeNode)
        scene.rootNode.addChildNode(planeNode)
        
        let constraint = SCNLookAtConstraint(target: cubeNode)
        constraint.isGimbalLockEnabled = true
        cameraNode.constraints = [constraint]
    }

}
