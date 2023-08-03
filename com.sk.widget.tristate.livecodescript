script "com.sk.widget.tristate"
/**
Title: Tri-state switch

Author: Stam Kapetanakis

Version: 1.0.0

Type: Widget

SVGIcon: M75.1875 98.9688C60.0318 98.9687 47.7188 111.251 47.7188 126.406L47.7188 128.688C47.7187 143.843 60.0318 156.125 75.1875 156.125L152.406 156.125C167.562 156.125 179.844 143.843 179.844 128.688L179.844 126.406C179.844 111.251 167.562 98.9688 152.406 98.9688L75.1875 98.9688ZM113.781 101.062C128.417 101.062 140.281 112.927 140.281 127.562C140.281 142.198 128.417 154.063 113.781 154.062C99.1457 154.062 87.2813 142.198 87.2812 127.562C87.2812 112.927 99.1457 101.062 113.781 101.062Z

Summary: Switch control with 3 states

Description:
A switch control with 3 states (left/centre/right)

In edit mode, resize in IDE to set size and aspect ratio. Assign a value of -1 (left), 0 (centre) or +1 (right) to the widget's switchValue property to control by code. 
Click on each 3rd of the widget to set switch in browse mode. Drag indicator to move 1 step in drag direction
Each switchValue can set a different color to the widget (the indicator remains unchanged)
Colours are set as properties.
*/

getProp propertyMetadata[pProperty]
    switch pProperty
        case "backgroundRightColor"
            return { \
                  "default": "#C90076", \
                  "label": "Color when switch in right position", \
                  "editor": "com.livecode.pi.color", \
                  "section": "Colors" }
            break
            
        case "backgroundLeftColor"
            return { \
                  "default": "#2986CC", \
                  "label": "Color when switch in left position", \
                  "editor": "com.livecode.pi.color", \
                  "section": "Colors" }
            break
            
        case "backgroundCentreColor"
            return { \
                  "default": "#F4F6F7", \
                  "label": "Color when switch in centre position", \
                  "editor": "com.livecode.pi.color", \
                  "section": "Colors" }
            break
            
        case "indicatorColor"
            return { \
                  "default": "#E6E8E8", \
                  "label": "Color of indicator switch", \
                  "editor": "com.livecode.pi.color", \
                  "section": "Colors" }
            break
            
        case "switchValue"
            return { \
                  "default": "0", \
                  "label": "-1 = left, 0 = centre, 1 = right position", \
                  "editor": "com.livecode.pi.text", \
                  "section": "Basic" }
            break
    end switch
end propertyMetadata


local sHasCreatedVisuals, sRect, sMouseX, sClickedIndicator
local sBackgroundRightID, sBackgroundLeftID, sBackgroundCentreID, sIndicatorID

on openControl
    createVisualControls
    layoutVisualControls
    updateVisualControls
end openControl

private command createVisualControls
    if sHasCreatedVisuals then exit createVisualControls
    set the width of me to 70
    set the height of me to 35
    
    create invisible graphic "backroundRight" in me
    put the id of it into sBackgroundRightID
    set the style of control id sBackgroundRightID to "roundRect"
    set the opaque of  control id sBackgroundRightID to true
    set the linesize of control id sBackgroundRightID to 1
    
    create invisible graphic "backgroundLeft" in me
    put the id of it into sBackgroundLeftID
    set the style of  control id sBackgroundLeftID  to "roundRect"
    set the opaque of  control id sBackgroundLeftID to true
    set the linesize of control id sBackgroundLeftID to 1
    
    create graphic "backgroundCentre" in me
    put the id of it into sBackgroundCentreID
    set the style of  control id sBackgroundCentreID to "roundRect"
    set the opaque of  control id sBackgroundCentreID to true
    set the linesize of control id sBackgroundCentreID to 1
    
    create graphic "indicator" in me
    put the id of it into sIndicatorID
    set the style of control id sIndicatorID to "oval"
    set the opaque of  control id sIndicatorID to true
    set the linesize of control id sIndicatorID to 1
    set the backgroundColor of control id sIndicatorID to "#E6E8E8"
    local tInnerGlow
    put "normal" into tInnerGlow["blendMode"]
    put 255,255,255 into tInnerGlow["color"]
    put "gaussian" into tInnerGlow["filter"]
    put 255 into tInnerGlow["opacity"]
    put 255 into tInnerGlow["range"]
    put 20 into tInnerGlow["size"]
    put "edge" into tInnerGlow["source"]
    put 0 into tInnerGlow["spread"]
    set the innerGlow of control id sIndicatorID to tInnerGlow
    
    layoutVisualControls
    put true into sHasCreatedVisuals
end createVisualControls

on resizeControl
    layoutVisualControls
end resizeControl

on mouseDown 
    put the rect of me into sRect
    if the mouseLoc is within the rect of control id sIndicatorID then 
        put true into sClickedIndicator
        put the mouseH into sMouseX
    end if
    pass mouseDown
end mouseDown

private command layoutVisualControls
    if not sHasCreatedVisuals then exit layoutVisualControls
    
    local tRect, tDiameter, tLength
    put the rect of me into tRect
    add 2 to item 1 of tRect
    add 2 to item 2 of tRect
    subtract 2 from item 3 of tRect
    subtract 2 from item 4 of tRect
    
    set the rect of  control id sBackgroundCentreID to tRect
    set the rect of control id sBackgroundLeftID to tRect
    set the rect of control id sBackgroundRightID to tRect
    
    put item 4 of tRect - item 2  of tRect  into tDiameter
    set the width of control id sIndicatorID to tDiameter - 4
    set the height of control id sIndicatorID to tDiameter -4
    
    set the roundRadius of control id sBackgroundCentreID to tDiameter
    set the roundRadius of control id sBackgroundLeftID to tDiameter
    set the roundRadius of control id sBackgroundRightID to tDiameter
    
    if the mouse is up then updateIndicatorForValue the switchValue of me
end layoutVisualControls

// backgroundRight
getProp backgroundRightColor
    local tColor
    put the backgroundRightColor of me into tColor
    if  tColor is empty then put "#C90076" into tColor
    return tColor
end backgroundRightColor

setProp backgroundRightColor pColor
    set the backgroundRightColor of me to pColor
    updateVisualControls
end backgroundRightColor

//backgroundLeft
getProp backgroundLeftColor
    local tColor
    put the backgroundLeftColor of me into tColor
    if  tColor is empty then put "#2986CC" into tColor
    return tColor
end backgroundLeftColor

setProp backgroundLeftColor pColor
    set the backgroundLeftColor of me to pColor
    updateVisualControls
end backgroundLeftColor

//backgroundCentre
getProp backgroundCentreColor
    local tColor
    put the backgroundCentreColor of me into tColor
    if  tColor is empty then put "#F4F6F7" into tColor
    return tColor
end backgroundCentreColor

setProp backgroundCentreColor pColor
    set the backgroundCentreColor of me to pColor
    updateVisualControls
end backgroundCentreColor

//indicator
getProp indicatorColor
    local tColor
    put the indicatorColor of me into tColor
    if  tColor is empty then put "#E6E8E8" into tColor
    return tColor
end indicatorColor

setProp indicatorColor pColor
    set the indicatorColor of me to pColor
    updateVisualControls
end indicatorColor

//switchValue
getProp switchValue
    local tValue
    put the switchValue of me into tValue
    if tValue is empty then put 0 into tValue
    return tValue
end switchValue

setProp switchValue pValue
    set the switchValue of me to pValue
    updateIndicatorForValue pValue
end switchValue

private command updateVisualControls
    if not sHasCreatedVisuals then exit updateVisualControls
    set the backgroundColor control id sBackgroundCentreID to the backgroundCentreColor of me
    set the backgroundColor control id sBackgroundLeftID to the backgroundLeftColor of me
    set the backgroundColor control id sBackgroundRightID to the backgroundRightColor of me
end updateVisualControls

private command updateIndicatorForValue pValue
    local tX
    switch pValue
        case -1
            set the visible of control id sBackgroundCentreID to false
            set the visible of control id sBackgroundRightID to false
            set the visible of control id sBackgroundLeftID to true
            put the left of control id sBackgroundLeftID + 3 + the width of control id sIndicatorID/2 into tX
            move control id sIndicatorID to tX, item 2 of the loc of control id sBackgroundCentreID in 200 milliseconds
            set the left of control id sIndicatorID to the left of control id sBackgroundLeftID + 2
            break
        case 0
            set the visible of control id sBackgroundCentreID to true
            set the visible of control id sBackgroundRightID to false
            set the visible of control id sBackgroundLeftID to false
            move control id sIndicatorID to the loc of control id sBackgroundCentreID in 200 milliseconds
            break
        case 1
            set the visible of control id sBackgroundCentreID to false
            set the visible of control id sBackgroundRightID to true
            set the visible of control id sBackgroundLeftID to false
            put the right of control id sBackgroundRightID - 3 - the width of control id sIndicatorID/2 into tX
            move control id sIndicatorID to tX, item 2 of the loc of control id sBackgroundRightID in 200 milliseconds
            set the right of control id sIndicatorID to the right of control id sBackgroundRightID  -2
            break
    end switch
end updateIndicatorForValue

on mouseUp pKey
    local tSegmentClicked, tRect, tR1, tR2, tR3, t3
    if sClickedIndicator then // drag indicator 1 step in drag direction
        local tValue
        put the switchValue of me into tValue
        if the mouseH - sMouseX > 0 and tValue < 1 then 
            add 1 to tValue
        else if the mouseH - sMouseX < 0 and tValue > -1 then
            subtract 1 from tValue
        end if
        set the switchValue of me to  tValue
    else
        put the width of control id sBackgroundCentreID / 3 into t3
        // establish 3 click zones to see if left, centre or right
        put the rect of control id sBackgroundCentreID into tR1
        put item 1 of tR1 +  t3 into item 3 of tR1
        put tR1 into tR2
        add t3 to item 1 of tR2
        add t3 to item 3 of tR2
        put tR2 into tR3
        add t3 to item 1 of tR3
        add t3 to item 3 of tR3
        // apply value based on click zone
        if the mouseLoc is within tR1 then 
            set the switchValue of me to -1
        else if the mouseLoc is within tR2 then
            set the switchValue of me to 0
        else if the mouseLoc is within tR3 then
            set the switchValue of me to 1
        end if
    end if
    put false into sClickedIndicator
    put empty into sMouseX
end mouseUp

on mouseRelease
    local tValue
    put the switchValue of me into tValue
    if the mouseH - sMouseX > 0 and tValue < 1 then 
        add 1 to tValue
    else if the mouseH - sMouseX < 0 and tValue > -1 then
        subtract 1 from tValue
    end if
    set the switchValue of me to  tValue
    put false into sClickedIndicator
    put empty into sMouseX
end mouseRelease
