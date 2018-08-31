//
//  GameElements.swift
//  PushMe
//
//  Created by Diego Espinosa on 8/20/18.
//  Copyright © 2018 Diego Espinosa. All rights reserved.
//

import SpriteKit

struct CollisionBitMask {
    
    static let Player:UInt32 = 0x00
    static let Obstacle:UInt32 = 0x01
    
}
enum ObstacleType:Int{
    case Small = 0
    case Medium = 1
    case Large = 2
    case Points = 3
}
enum RowType:Int{
    case oneS = 0
    case oneM = 1
    case oneL = 2
    case twoS = 3
    case twoM = 4
    case threeS = 5
}

extension GameScene{
    func addPlayer(){
        player = SKSpriteNode(color: UIColor.red, size: CGSize(width: 50, height: 50))
        player.position = CGPoint(x: self.size.width / 2, y: 350)
        player.name = "PLAYER"
        player.physicsBody?.isDynamic = false
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.categoryBitMask = CollisionBitMask.Player
        player.physicsBody?.collisionBitMask = 0
        player.physicsBody?.contactTestBitMask = CollisionBitMask.Obstacle
        
        player2 = SKSpriteNode(color: UIColor.red, size: CGSize(width: 50, height: 50))
        player2.position = CGPoint(x: self.size.width/2, y: 350)
        player2.name = "PLAYER"
        player2.physicsBody?.isDynamic = false
        player2.physicsBody = SKPhysicsBody(rectangleOf: player2.size)
        player2.physicsBody?.categoryBitMask = CollisionBitMask.Player
        player2.physicsBody?.collisionBitMask = 0
        player2.physicsBody?.contactTestBitMask = CollisionBitMask.Obstacle
        
        addChild(player)
        addChild(player2)
        
        initalPlayerPosition = player.position
        
        score = 0
    }
    
    func addObstacle (type: ObstacleType) -> SKSpriteNode{
        let obstacle = SKSpriteNode(color: UIColor.white, size: CGSize(width: 0, height: 30))
        obstacle.name = "OBSTACLE"
        obstacle.physicsBody?.isDynamic = true

        switch type{
        case .Small:
            obstacle.size.width = self.size.width * 0.2
            break
        case .Medium:
            obstacle.size.width = self.size.width * 0.36
            break
        case .Large:
            obstacle.size.width = self.size.width * 0.75
            break
        case .Points:
            obstacle.size.width = 30
            obstacle.size.height = 30
            obstacle.color = UIColor.green
            obstacle.name = "POINTS"
            break
        }
        obstacle.position = CGPoint(x: 0, y: self.size.height + obstacle.size.height)
        obstacle.physicsBody = SKPhysicsBody(rectangleOf: obstacle.size)
        obstacle.physicsBody?.categoryBitMask = CollisionBitMask.Obstacle
        obstacle.physicsBody?.collisionBitMask = 0
        
        return obstacle
    }
    
    func addMovement(obstacle:SKSpriteNode){
        var actionArray = [SKAction]()
        
        actionArray.append(SKAction.move(to: CGPoint(x: obstacle.position.x, y: -obstacle.size.height), duration: TimeInterval(3)))
        actionArray.append(SKAction.removeFromParent())
        
        obstacle.run(SKAction.sequence(actionArray))
    }
    
    func addRow (type:RowType){
        switch type{
        case .oneS:
            let obst = addObstacle(type: .Small)
            let point = addObstacle(type: .Points)
            let pointTwo = addObstacle(type: .Points)
            
            obst.position = CGPoint(x: self.size.width / 2, y: obst.position.y)
            point.position = CGPoint(x: self.size.width / 2 - 200, y: point.position.y)
            pointTwo.position = CGPoint(x: self.size.width / 2 + 200, y: pointTwo.position.y)
            
            addMovement(obstacle: obst)
            addMovement(obstacle: point)
            addMovement(obstacle: pointTwo)
            
            addChild(obst)
            addChild(point)
            addChild(pointTwo)
            break
        case .oneM:
            let obst = addObstacle(type: .Medium)
            let point = addObstacle(type: .Points)
            let pointTwo = addObstacle(type: .Points)
            
            obst.position = CGPoint(x: self.size.width / 2, y: obst.position.y)
            point.position = CGPoint(x: self.size.width / 2 - 250, y: point.position.y)
            pointTwo.position = CGPoint(x: self.size.width / 2 + 250, y: pointTwo.position.y)
            
            addMovement(obstacle: obst)
            addMovement(obstacle: point)
            addMovement(obstacle: pointTwo)
            
            addChild(obst)
            addChild(point)
            addChild(pointTwo)
            break
        case .oneL:
            let obst = addObstacle(type: .Large)
            let point = addObstacle(type: .Points)
            let pointTwo = addObstacle(type: .Points)
            
            obst.position = CGPoint(x: self.size.width / 2, y: obst.position.y)
            point.position = CGPoint(x: self.size.width / 2 + 330, y: point.position.y)
            pointTwo.position = CGPoint(x: self.size.width / 2 - 330, y: pointTwo.position.y)
            
            addMovement(obstacle: obst)
            addMovement(obstacle: point)
            addMovement(obstacle: pointTwo)
            
            addChild(obst)
            addChild(point)
            addChild(pointTwo)
            break
        case .twoS:
            let obst1 = addObstacle(type: .Small)
            let obst2 = addObstacle(type: .Small)
            let point = addObstacle(type: .Points)
            
            obst1.position = CGPoint(x: obst1.size.width + 50, y: obst1.position.y)
            obst2.position = CGPoint(x: self.size.width - obst2.size.width - 50, y: obst1.position.y)
            point.position = CGPoint(x: self.size.width / 2, y: point.position.y)
            
            addMovement(obstacle: obst1)
            addMovement(obstacle: obst2)
            addMovement(obstacle: point)
            
            addChild(obst1)
            addChild(obst2)
            addChild(point)
            break
        case .twoM:
            let obst1 = addObstacle(type: .Medium)
            let obst2 = addObstacle(type: .Medium)
            let point = addObstacle(type: .Points)
            
            obst1.position = CGPoint(x: obst1.size.width / 2 + 50, y: obst1.position.y)
            obst2.position = CGPoint(x: self.size.width - obst2.size.width / 2 - 50, y: obst1.position.y)
            point.position = CGPoint(x: self.size.width / 2, y: point.position.y)
            
            addMovement(obstacle: obst1)
            addMovement(obstacle: obst2)
            addMovement(obstacle: point)
            
            addChild(obst1)
            addChild(obst2)
            addChild(point)
            break
        case .threeS:
            let obst1 = addObstacle(type: .Small)
            let obst2 = addObstacle(type: .Small)
            let obst3 = addObstacle(type: .Small)
            let point = addObstacle(type: .Points)
            let pointTwo = addObstacle(type: .Points)
            
            obst1.position = CGPoint(x: obst1.size.width / 2 + 50, y: obst1.position.y) //Left
            obst2.position = CGPoint(x: self.size.width - obst2.size.width / 2 - 50, y: obst1.position.y) //Right
            obst3.position = CGPoint(x: self.size.width / 2, y: obst1.position.y) //Center
            point.position = CGPoint(x: self.size.width / 2 + 125, y: point.position.y)
            pointTwo.position = CGPoint(x: self.size.width / 2 - 125, y: pointTwo.position.y)
            
            addMovement(obstacle: obst1)
            addMovement(obstacle: obst2)
            addMovement(obstacle: obst3)
            addMovement(obstacle: point)
            addMovement(obstacle: pointTwo)
            
            addChild(obst1)
            addChild(obst2)
            addChild(obst3)
            addChild(point)
            addChild(pointTwo)
            break
        }
    }
}
