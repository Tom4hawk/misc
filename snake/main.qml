import QtQuick 2.8
import QtQuick.Window 2.2

Window {
    visible: true
    width: 640
    height: 640
    title: "Snake"

    Canvas {
        id: canvas
        anchors.fill: parent
        focus: true

        // Move vector
        property int move_x: 0
        property int move_y: 0

        // Player head coordinates
        property int player_x: 10
        property int player_y: 10

        // Height nad width of our block in pixels
        property int block_size: 32

        // Height and width of our "arena" in blocks
        property int arena_size: 20

        // Start coordinates for red block
        property int food_x: 15
        property int food_y: 15

        // Coordinates of every element in the tail
        property variant trail: []

        // Tail size
        property int tail: 5

        onPaint: {
            // Calculate new head position
            player_x += move_x
            player_y += move_y

            if (player_x < 0)
                player_x = arena_size - 1
            if (player_x > (arena_size - 1))
                player_x = 0
            if (player_y < 0)
                player_y = arena_size - 1
            if (player_y > arena_size - 1)
                player_y = 0

            var ctx = canvas.getContext('2d')

            // Let's clear our canvas
            ctx.fillStyle = "black"
            ctx.fillRect(0, 0, canvas.width, canvas.height)

            // Draw snake
            ctx.fillStyle = "green"

            for (var i = 0; i < trail.length; i++) {
                ctx.fillRect(trail[i].x * block_size, trail[i].y * block_size, block_size - 2, block_size - 2)
                if (trail[i].x === player_x && trail[i].y === player_y) {
                    tail = 5
                }
            }
            trail.push({x: player_x, y: player_y})

            // We tried to eat our tail, here is the punishment ;)
            while (trail.length > tail) {
                trail.shift()
            }

            // We ate red block
            if (food_x == player_x && food_y == player_y) {
                tail++

                // New coordinates for our red block
                food_x = Math.floor(Math.random() * arena_size)
                food_y = Math.floor(Math.random() * arena_size)
            }

            // Place red block
            ctx.fillStyle = "red"
            ctx.fillRect(food_x * block_size, food_y * block_size, block_size - 2, block_size - 2)
        }

        Keys.onPressed: {
            switch (event.key) {
            case Qt.Key_Left:
                move_x = -1
                move_y = 0
                break
            case Qt.Key_Up:
                move_x = 0
                move_y = -1
                break
            case Qt.Key_Right:
                move_x = 1
                move_y = 0
                break
            case Qt.Key_Down:
                move_x = 0
                move_y = 1
                break
            }
        }

        Timer {
            id: gameLoop
            interval: 70
            running: true
            repeat: true
            onTriggered: canvas.requestPaint()
        }
    }
}
