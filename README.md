# Tri-state control widget
LiveCode widget - tri-state control (requires LC 10 DP5 or higher)

Current version: 1.0.4 - see [changelog](/changelog.md)
A special thankyou to @BerndN for his invaluable contributions!

## Tri-state Switch control (script widget external)
<img width="430" alt="Screenshot 2023-08-21 at 14 10 34" src="https://github.com/stam66/tristate/assets/5677273/90f57dee-e81e-4d0b-8625-794cf19a9d39">

An alternative to the built-in switch widget which offers a trinary instead of binary choice.
- Optionally inline labels can be displayed. Label is sized by widget height within constraints of max/min text size properites (text panel of property inpector) and textColor is appropriate to background luminosity (dark text on light backgrounds and vice versa).
- Different background colours can be assigned depending on state (left/center/right)
- A _tristateChanged_ message is sent up the object hierarchy if change needs to be captured for processing
- Properties are settable directly in the Basic, Contents, Colors and Text panels of it's property inspector.

Widget designed with the new script widget and requires LiveCode 10.0 DP5 or higher.
Use the Extension Manager (Tools menu) to install the widget (the .lce file). After installation an new icon appears in the Tools palette

Sourcecode and widget available under MIT licence.
To build the extension from source, follow the instructions at the end of the lesson: https://lessons.livecode.com/m/98525/l/1672543-creating-a-script-widget
