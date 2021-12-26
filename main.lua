function love.load()
    arenaWidth = love.graphics.getWidth()
    arenaHeight = love.graphics.getHeight()

    shipX = arenaWidth / 2
    shipY = arenaHeight / 2
    shipAngle = 0

    shipSpeedX = 0
    shipSpeedY = 0

    bullets = {}
end

function love.keypressed(key)
    if key == 's' then
        table.insert(bullets, {
            x = shipX,
            y = shipY
        })
    end
end

function love.update(dt)
    local turnSpeed = 10

    if love.keyboard.isDown('right') then
        shipAngle = shipAngle + turnSpeed*dt
    end
    if love.keyboard.isDown('left') then
        shipAngle = shipAngle - turnSpeed * dt
    end
    if love.keyboard.isDown('up') then
        local shipSpeed = 100

        shipSpeedX = shipSpeedX + math.cos( shipAngle ) * shipSpeed * dt
        shipSpeedY = shipSpeedY + math.sin( shipAngle ) * shipSpeed * dt
    end

    shipX = (shipX + shipSpeedX * dt) % arenaWidth
    shipY = (shipY + shipSpeedY * dt) % arenaHeight
    shipAngle = shipAngle % (2 * math.pi)
end

function love.draw()
    for y = -1, 1 do
        for x = -1, 1 do
            love.graphics.origin()
            love.graphics.translate( x * arenaWidth, y * arenaHeight )
            
            love.graphics.setColor( 0, 0, 1 )
            love.graphics.circle( 'fill', shipX, shipY, 30 )
        
            local shipCircleDistance = 20
            love.graphics.setColor( 0, 1, 1 )
            love.graphics.circle(
                'fill',
                shipX + math.cos( shipAngle ) * shipCircleDistance,
                shipY + math.sin( shipAngle ) * shipCircleDistance,
                5
            )

            for bulletIndex, bullet in ipairs(bullets) do
                love.graphics.setColor(0, 1, 0)
                love.graphics.circle('fill', bullet.x, bullet.y, 5)
            end
        end
    end

    love.graphics.origin()
    love.graphics.setColor(1, 1, 1)
    love.graphics.print('shipAngle: '..shipAngle)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(table.concat({
        'shipAngle: '..shipAngle,
        'shipX: '..shipX,
        'shipY: '..shipY,
        'shipSpeedX: '..shipSpeedX,
        'shipSpeedY: '..shipSpeedY,
    }, '\n'))
end