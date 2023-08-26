### Changes in version 1.0.43 <br>
Fix for slow initalisation provided by @BerndN (thank you!)

### Changes in version 1.0.42 <br>
Minor update to include code by @BerndN for improvements in Properties documentation for the LiveCode Dictionary

### Changes in version 1.0.41 <br>
- thanks to @BerndD who spotted that the switchValue was being overwritten at initialisation and resetting the widget to neutral position on startup. This is now fixed.
- Cleaned up documentation

### Changes in version 1.0.4: <br>
- thanks to @BerndN for improving the vertical text align - code modified to include his algorithm
- thanks to @BerndN for spotting inconsistent drag behavior - now fixed (drag will only happen if dragging from the indicator, not the background)
- minor code cleanup

  
### Changes in version 1.0.3: <br>
- Thanks to @BerndN for his suggestions on improving the existing widget
    - the indicator no longer meanders on resizing the widget (i kind of miss that!)
    - default colors show correctly in the property inspector (while atypical for LC, it's better)
    - the widget emits a 'triStateChanged' message up the object hierarchy that can be managed to respond to changes


- **New feature: optional inline labels** <br>
<img width="491" alt="tristate" src="https://github.com/stam66/tristate/assets/5677273/be4ef39b-0f56-45e0-b53f-599cc08ecbc7"><br>
    - property 'hasLabels' determines if labels are show or not ('basic' secion of the property inspector)
    - there are 3 labels: 2 short ones (1 char) either side of the indicator for when that's in center position and 1 long label for left or right setting
    - contents of the labels can be set in the 'content' secion of the Property Inspector
    - the labels resize and reposition with resizing the widget. The textSize scales between max and min values which can be set in the 'text' section of the PI
    - the label's textColor is determined by the luminosity of background color (ie dark text of light backgrounds and vice versa).
<img width="707" alt="PI panels" src="https://github.com/stam66/tristate/assets/5677273/9167d955-a4a9-41f1-972a-ca11bd5ca69e">


### Changes in version 1.0.2: <br>
Simplified significantly:
- just 2 graphics used
- simpler variable naming
- changed switchValue options to Left/Center/Right
- added enum property inspector for switchValue
