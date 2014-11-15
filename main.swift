enum Direction: String, Printable {
    case North = "North"
    case East  = "East"
    case South = "South"
    case West  = "West"

    var description: String {
        return String(self.rawValue)
    }

    var left: Direction {
        switch (self) {
        case .North:
            return .West
        case .East:
            return .North
        case .South:
            return .East
        case .West:
            return .South
        }
    }

    var right: Direction {
        switch (self) {
        case .North:
            return .East
        case .East:
            return .South
        case .South:
            return .West
        case .West:
            return .North
        }
    }
}

struct Placement: Printable {
    let x: Int
    let y: Int
    let facing: Direction

    var description: String {
        return "\(x),\(y),\(facing)"
    }

    func next() -> Placement? {
        switch (x, y, facing) {
        case (_, _, .North) where y+1 < 5:
            return Placement(x: x, y: y+1, facing: .North)
        case (_, _, .East) where x+1 < 5:
            return Placement(x: x+1, y: y, facing: .East)
        case (_, _, .South) where y-1 >= 0:
            return Placement(x: x, y: y-1, facing: .South)
        case (_, _, .West) where x-1 >= 0:
            return Placement(x: x-1, y: y, facing: .West)
        default:
            return nil
        }
    }

    func left() -> Placement {
        return Placement(x: x, y: y, facing: facing.left)
    }

    func right() -> Placement {
        return Placement(x: x, y: y, facing: facing.right)
    }
}

class Robot {
    var placement: Placement?

    func move() {
        if let newPlacement = placement?.next() {
            self.placement = newPlacement
        }
    }

    func turnLeft() {
        if let newPlacement = placement?.left() {
            self.placement = newPlacement
        }
    }

    func turnRight() {
        if let newPlacement = placement?.right() {
            self.placement = newPlacement
        }
    }
}

func reportRobotLocation(robot: Robot) {
    if let placement = robot.placement {
        println(placement)
    } else {
        println("Robot not placed.")
    }
}

let robot = Robot()
reportRobotLocation(robot)

robot.move()
reportRobotLocation(robot)

robot.placement = Placement(x: 0, y: 0, facing: Direction.North)
reportRobotLocation(robot)

robot.move()
reportRobotLocation(robot)

robot.placement = Placement(x: 0, y: 0, facing: Direction.South)
reportRobotLocation(robot)
robot.move()
reportRobotLocation(robot)

robot.placement = Placement(x: 0, y: 0, facing: Direction.North)
reportRobotLocation(robot)
for _ in 1...5 {
    robot.move()
    reportRobotLocation(robot)
}

robot.turnLeft()
reportRobotLocation(robot)

robot.placement = Placement(x: 0, y: 0, facing: Direction.North)
robot.turnRight()
reportRobotLocation(robot)
robot.move()
reportRobotLocation(robot)
