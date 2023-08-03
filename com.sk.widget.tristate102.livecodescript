script "com.sk.widget.tristate102"
/**
Title: Tri-state switch 1.0.2

Author: Stam Kapetanakis

Version: 1.0.2 

Type: Widget

SVGIcon: M75.1875 98.9688C60.0318 98.9687 47.7188 111.251 47.7188 126.406L47.7188 128.688C47.7187 143.843 60.0318 156.125 75.1875 156.125L152.406 156.125C167.562 156.125 179.844 143.843 179.844 128.688L179.844 126.406C179.844 111.251 167.562 98.9688 152.406 98.9688L75.1875 98.9688ZM113.781 101.062C128.417 101.062 140.281 112.927 140.281 127.562C140.281 142.198 128.417 154.063 113.781 154.062C99.1457 154.062 87.2813 142.198 87.2812 127.562C87.2812 112.927 99.1457 101.062 113.781 101.062Z

Summary: Switch control with 3 states

Description:
A switch control with 3 states (left/center/right)

In edit mode, resize in IDE to set size and aspect ratio. 
Assign a value (left, center or right) setting the switchValue either by code or in property panel.
Click on each 3rd of the widget to set switch in browse mode. Drag indicator to move 1 step in drag direction.
Each switchValue can set a different color to the widget.
Colours are set in the property panel or by code (set the leftColor, centerColor, rightColor and indicatorColor respectively).
*/

getProp propertyMetadata[pProperty]
    switch pProperty
        case "rightColor"
            return { \
                  "default": "#C90076", \
                  "label": "Color when switch in right position", \
                  "editor": "com.livecode.pi.color", \
                  "section": "Colors" }
            break
            
        case "leftColor"
            return { \
                  "default": "#2986CC", \
                  "label": "Color when switch in left position", \
                  "editor": "com.livecode.pi.color", \
                  "section": "Colors" }
            break
            
        case "centerColor"
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
                  "default": "Center", \
                  "label": "Switch position", \
                  "editor": "com.livecode.pi.enum", \
                  "options": "Left,Center,Right", \
                  "section": "Basic" }
            break
    end switch
end propertyMetadata

      
local sHasCreatedVisuals, sMouseX, sClickedIndicator
local sBackroundID, sIndicatorID

########################### PROPERTIES ###########################
// backgroundRight
getProp rightColor
    local tColor
    put the rightColor of me into tColor
    if  tColor is empty then put "#C90076" into tColor
    return tColor
end rightColor

setProp rightColor pColor
    set the rightColor of me to pColor
    updateVisualControls
end rightColor

//backgroundLeft
getProp leftColor
    local tColor
    put the leftColor of me into tColor
    if  tColor is empty then put "#2986CC" into tColor
    return tColor
end leftColor

setProp leftColor pColor
    set the leftColor of me to pColor
    updateVisualControls
end leftColor

//backgroundCentre
getProp centerColor
    local tColor
    put the centerColor of me into tColor
    if  tColor is empty then put "#F4F6F7" into tColor
    return tColor
end centerColor

setProp centerColor pColor
    set the centerColor of me to pColor
    updateVisualControls
end centerColor

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

########################### /PROPERTIES ##########################

on openControl
    createVisualControls
    layoutVisualControls
    updateVisualControls
end openControl

on resizeControl
    layoutVisualControls
end resizeControl

private command updateVisualControls
    if sHasCreatedVisuals then exit updateVisualControls
    set the backgroundColor control id sBackroundID to the centerColor of me
    set the backgroundColor of control id sIndicatorID to the indicatorColor of me
end updateVisualControls

private command createVisualControls
    if sHasCreatedVisuals then exit createVisualControls
    if the width of me is 0 or the width of me is empty then // added because it was generating zero-width widget
     set the width of me to 70
     set the height of me to 35
    end if
    
    create graphic "background" in me
    put the id of it into sBackroundID
    set the style of  control id sBackroundID to "roundRect"
    set the opaque of  control id sBackroundID to true
    set the linesize of control id sBackroundID to 1
    
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

private command layoutVisualControls
    if not sHasCreatedVisuals then exit layoutVisualControls
    
    local tRect, tDiameter, tLength
    put the rect of me into tRect
    add 2 to item 1 of tRect
    add 2 to item 2 of tRect
    subtract 2 from item 3 of tRect
    subtract 2 from item 4 of tRect
    set the rect of  control id sBackroundID to tRect
    
    put item 4 of tRect - item 2  of tRect  into tDiameter
    set the width of control id sIndicatorID to tDiameter - 4
    set the height of control id sIndicatorID to tDiameter - 4
    set the roundRadius of control id sBackroundID to tDiameter
    if the mouse is up then updateIndicatorForValue the switchValue of me 
end layoutVisualControls

private command updateIndicatorForValue pValue
    local tX
    switch pValue
        case "Left"
            set the backgroundColor of control id sBackroundID to the leftColor of me 
            put the left of control id sBackroundID + 3 + the width of control id sIndicatorID/2 into tX
            move control id sIndicatorID to tX, item 2 of the loc of control id sBackroundID in 200 milliseconds
            set the left of control id sIndicatorID to the left of control id sBackroundID + 2
            break
        case "Center"
            set the backgroundColor of control id sBackroundID to the centerColor of me 
            move control id sIndicatorID to the loc of control id sBackroundID in 200 milliseconds
            break
        case "Right"
            set the backgroundColor of control id sBackroundID to the rightColor of me 
            put the right of control id sBackroundID - 3 - the width of control id sIndicatorID/2 into tX
            move control id sIndicatorID to tX, item 2 of the loc of control id sBackroundID in 200 milliseconds
            set the right of control id sIndicatorID to the right of control id sBackroundID  -2
            break
    end switch
end updateIndicatorForValue

on mouseDown 
    if the mouseLoc is within the rect of control id sIndicatorID then 
        put true into sClickedIndicator
        put the mouseH into sMouseX
    end if
    pass mouseDown
end mouseDown

on mouseUp pKey
    local tSegmentClicked, tRect, tR1, tR2, tR3, t3
    if sClickedIndicator then   // drag indicator 1 step in drag direction
        local tValue
        put the switchValue of me into tValue
        if the mouseH - sMouseX > 0 and tValue is "Left" then // go right
            put "Center" into tValue
        else if the mouseH - sMouseX > 0 and tValue is "Center" then // go right
            put "Right" into tValue    
        else if the mouseH - sMouseX < 0 and tValue is "Right" then //go left
            put "Center" into tValue
        else if the mouseH - sMouseX < 0 and tValue is "Center" then //go left
            put "Left" into tValue
        end if
        set the switchValue of me to tValue
    else                        // establish 3 click zones to see if left, centre or right
        put the width of control id sBackroundID / 3 into t3
        put the rect of control id sBackroundID into tR1
        put item 1 of tR1 +  t3 into item 3 of tR1
        put tR1 into tR2
        add t3 to item 1 of tR2
        add t3 to item 3 of tR2
        put tR2 into tR3
        add t3 to item 1 of tR3
        add t3 to item 3 of tR3
        // apply value based on click zone
        if the mouseLoc is within tR1 then 
            set the switchValue of me to "Left"
        else if the mouseLoc is within tR2 then
            set the switchValue of me to "Center"
        else if the mouseLoc is within tR3 then
            set the switchValue of me to "Right"
        end if
    end if
    put false into sClickedIndicator
    put empty into sMouseX
end mouseUp

on mouseRelease
    local tValue
    put the switchValue of me into tValue
    if the mouseH - sMouseX > 0 and tValue is "Left" then // go right
        put "Center" into tValue
    else if the mouseH - sMouseX > 0 and tValue is "Center" then // go right
        put "Right" into tValue    
    else if the mouseH - sMouseX < 0 and tValue is "Right" then //go left
        put "Center" into tValue
    else if the mouseH - sMouseX < 0 and tValue is "Center" then //go left
        put "Left" into tValue
    end if
    set the switchValue of me to tValue
    put false into sClickedIndicator
    put empty into sMouseX
end mouseRelease


