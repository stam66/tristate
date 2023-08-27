# Tri-state control widget
LiveCode widget - tri-state control (requires LC 10 DP5 or higher)

Current version: 1.0.44 - see [changelog](/changelog.md)<br>
A special thankyou to @BerndN for his invaluable contributions!

## Tri-state Switch control (script widget external)
<img width="374" alt="Tristate switch examples" src="https://github.com/stam66/tristate/assets/5677273/e66f3b4e-e1af-4d7d-b229-7cb73ae4f5b4">


An alternative to the built-in switch widget which offers a trinary instead of binary choice.
- Optionally show inline labels which are scaled and coloured automatically.
- Different background colours can be assigned depending on state (left/center/right)
- A _tristateChanged_ message is sent up the object hierarchy if change needs to be captured for processing
- Properties are settable directly in the Basic, Contents, Colors and Text panels of its property inspector.

Created with the new script widget facility and requires LiveCode 10.0 DP5 or higher.
Use the Extension Manager (Tools menu) to install the widget (the .lce file). After installation an new icon appears in the Tools palette and the Dictionary will include a short API.

Sourcecode and widget available under MIT licence.
To build the extension from source, follow the instructions at the end of the lesson: https://lessons.livecode.com/m/98525/l/1672543-creating-a-script-widget
