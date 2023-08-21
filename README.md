# Tri-state control widget
LiveCode widget - tri-state control (requires LC 10 DP5 or higher)

### Changes in version 1.0.3: <br>
- Thanks to Bernd for his suggestions on improving the existing widget
    - the indicator no longer meanders on resizing the widget (i kind of miss that!)
    - default colors show correctly in the property inspector (while atypical for LC, it's better)
    - the widget emits a 'triStateChanged' message up the object hierarchy that can be managed to respond to changes
<br><br>
- **New feature: optional inline labels** <br>
<img width="491" alt="tristate" src="https://github.com/stam66/tristate/assets/5677273/be4ef39b-0f56-45e0-b53f-599cc08ecbc7"><br>
    - property 'hasLabels' determines if labels are show or not ('basic' secion of the property inspector)
    - there are 3 labels: 2 short ones (1 char) either side of the indicator for when that's in center position and 1 long label for left or right setting
    - contents of the labels can be set in the 'content' secion of the Property Inspector
    - the labels resize and reposition with resizing the widget. The textSize scales between max and min values which can be set in the 'text' section of the PI
    - the label's textColor is determined by the luminosity of background color (ie dark text of light backgrounds and vice versa).
<img width="707" alt="PI panels" src="https://github.com/stam66/tristate/assets/5677273/9167d955-a4a9-41f1-972a-ca11bd5ca69e">

<br><br><br>

### Changes in version 1.0.2: <br>
Simplified significantly:
- just 2 graphics used
- simpler variable naming
- changed switchValue options to Left/Center/Right
- added enum property inspector for switchValue
<br><br><br>
## Tri-state Switch control
<img width="323" alt="Screenshot 2023-08-03 at 01 14 55" src="https://github.com/stam66/tristate/assets/5677273/e12d496b-d29d-426f-8126-e2ba32ad7b23">

Widget designed with the new script widget facility available in LiveCode 10.0 DP5 or higher.
Use the Extension Manager (Tools menu) to install the widget (the .lce file). While possible to 'install' in earlier version of LiveCode it won't work.

After installation an new icon appears in the Tools palette

Resize in IDE to change aspect ratio to requirement. The indicator may occupy the central/defaut position, left or right. This is determined by the switchValue which can be set in the property panel, by clicking on any 3rd of the control or by dragging the indicator. <br><img width="432" alt="Screenshot 2023-08-03 at 17 13 21" src="https://github.com/stam66/tristate/assets/5677273/161a58cd-0f83-482c-8fc6-a419d46505ff">

The colour of the non-indicator portion changes with each setting and can be set in the PI.
<img width="432" alt="Screenshot 2023-08-03 at 17 13 26" src="https://github.com/stam66/tristate/assets/5677273/97a3a2c5-4ed4-45c5-b140-87f4abe92d50">



Sourcecode and widget available under MIT licence.
To build the extension from source, follow the instructions at the end of the lesson: https://lessons.livecode.com/m/98525/l/1672543-creating-a-script-widget
