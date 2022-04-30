/*******************************************************************************************
*
*   raygui v3.1 - A simple and easy-to-use immediate-mode gui library
*
*   DESCRIPTION:
*
*   raygui is a tools-dev-focused immediate-mode-gui library based on raylib but also
*   available as a standalone library, as long as input and drawing functions are provided.
*
*   Controls provided:
*
*   # Container/separators Controls
*       - WindowBox
*       - GroupBox
*       - Line
*       - Panel
*       - ScrollPanel
*
*   # Basic Controls
*       - Label
*       - Button
*       - LabelButton   --> Label
*       - Toggle
*       - ToggleGroup   --> Toggle
*       - CheckBox
*       - ComboBox
*       - DropdownBox
*       - TextBox
*       - TextBoxMulti
*       - ValueBox      --> TextBox
*       - Spinner       --> Button, ValueBox
*       - Slider
*       - SliderBar     --> Slider
*       - ProgressBar
*       - StatusBar
*       - ScrollBar     // TODO: Really? Do we need it? We have GuiScrollPanel()
*       - DummyRec
*       - Grid
*
*   # Advance Controls
*       - ListView
*       - ColorPicker   --> ColorPanel, ColorBarHue
*       - MessageBox    --> Window, Label, Button
*       - TextInputBox  --> Window, Label, TextBox, Button
*
*   It also provides a set of functions for styling the controls based on its properties (size, color).
*
*
*   RAYGUI STYLE (guiStyle):
*
*   raygui uses a global data array for all gui style properties (allocated on data segment by default),
*   when a new style is loaded, it is loaded over the global style... but a default gui style could always be
*   recovered with GuiLoadStyleDefault() function, that overwrites the current style to the default one
*
*   The global style array size is fixed and depends on the number of controls and properties:
*
*       static unsigned int guiStyle[RAYGUI_MAX_CONTROLS*(RAYGUI_MAX_PROPS_BASE + RAYGUI_MAX_PROPS_EXTENDED)];
*
*   guiStyle size is by default: 16*(16 + 8) = 384*4 = 1536 bytes = 1.5 KB
*
*   Note that the first set of BASE properties (by default guiStyle[0..15]) belong to the generic style
*   used for all controls, when any of those base values is set, it is automatically populated to all
*   controls, so, specific control values overwriting generic style should be set after base values.
*
*   After the first BASE set we have the EXTENDED properties (by default guiStyle[16..23]), those
*   properties are actually common to all controls and can not be overwritten individually (like BASE ones)
*   Some of those properties are: TEXT_SIZE, TEXT_SPACING, LINE_COLOR, BACKGROUND_COLOR
*
*   Custom control properties can be defined using the EXTENDED properties for each independent control.
*
*   TOOL: rGuiStyler is a visual tool to customize raygui style.
*
*
*   RAYGUI ICONS (guiIcons):
*
*   raygui could use a global array containing icons data (allocated on data segment by default),
*   a custom icons set could be loaded over this array using GuiLoadIcons(), but loaded icons set
*   must be same RAYGUI_ICON_SIZE and no more than RAYGUI_ICON_MAX_ICONS will be loaded
*
*   Every icon is codified in binary form, using 1 bit per pixel, so, every 16x16 icon
*   requires 8 integers (16*16/32) to be stored in memory.
*
*   When the icon is draw, actually one quad per pixel is drawn if the bit for that pixel is set.
*
*   The global icons array size is fixed and depends on the number of icons and size:
*
*       static unsigned int guiIcons[RAYGUI_ICON_MAX_ICONS*RAYGUI_ICON_DATA_ELEMENTS];
*
*   guiIcons size is by default: 256*(16*16/32) = 2048*4 = 8192 bytes = 8 KB
*
*   TOOL: rGuiIcons is a visual tool to customize raygui icons.
*
*
*   CONFIGURATION:
*
*   #define RAYGUI_IMPLEMENTATION
*       Generates the implementation of the library into the included file.
*       If not defined, the library is in header only mode and can be included in other headers
*       or source files without problems. But only ONE file should hold the implementation.
*
*   #define RAYGUI_STANDALONE
*       Avoid raylib.h header inclusion in this file. Data types defined on raylib are defined
*       internally in the library and input management and drawing functions must be provided by
*       the user (check library implementation for further details).
*
*   #define RAYGUI_NO_ICONS
*       Avoid including embedded ricons data (256 icons, 16x16 pixels, 1-bit per pixel, 2KB)
*
*   #define RAYGUI_CUSTOM_ICONS
*       Includes custom ricons.h header defining a set of custom icons,
*       this file can be generated using rGuiIcons tool
*
*
*   VERSIONS HISTORY:
*       3.1 (12-Jan-2021) REVIEWED: Default style for consistency (aligned with rGuiLayout v2.5 tool)
*                         REVIEWED: GuiLoadStyle() to support compressed font atlas image data and unload previous textures
*                         REVIEWED: External icons usage logic
*                         REVIEWED: GuiLine() for centered alignment when including text
*                         RENAMED: Multiple controls properties definitions to prepend RAYGUI_
*                         RENAMED: RICON_ references to RAYGUI_ICON_ for library consistency
*                         Projects updated and multiple tweaks
*       3.0 (04-Nov-2021) Integrated ricons data to avoid external file
*                         REDESIGNED: GuiTextBoxMulti()
*                         REMOVED: GuiImageButton*()
*                         Multiple minor tweaks and bugs corrected
*       2.9 (17-Mar-2021) REMOVED: Tooltip API
*       2.8 (03-May-2020) Centralized rectangles drawing to GuiDrawRectangle()
*       2.7 (20-Feb-2020) ADDED: Possible tooltips API
*       2.6 (09-Sep-2019) ADDED: GuiTextInputBox()
*                         REDESIGNED: GuiListView*(), GuiDropdownBox(), GuiSlider*(), GuiProgressBar(), GuiMessageBox()
*                         REVIEWED: GuiTextBox(), GuiSpinner(), GuiValueBox(), GuiLoadStyle()
*                         Replaced property INNER_PADDING by TEXT_PADDING, renamed some properties
*                         ADDED: 8 new custom styles ready to use
*                         Multiple minor tweaks and bugs corrected
*       2.5 (28-May-2019) Implemented extended GuiTextBox(), GuiValueBox(), GuiSpinner()
*       2.3 (29-Apr-2019) ADDED: rIcons auxiliar library and support for it, multiple controls reviewed
*                         Refactor all controls drawing mechanism to use control state
*       2.2 (05-Feb-2019) ADDED: GuiScrollBar(), GuiScrollPanel(), reviewed GuiListView(), removed Gui*Ex() controls
*       2.1 (26-Dec-2018) REDESIGNED: GuiCheckBox(), GuiComboBox(), GuiDropdownBox(), GuiToggleGroup() > Use combined text string
*                         REDESIGNED: Style system (breaking change)
*       2.0 (08-Nov-2018) ADDED: Support controls guiLock and custom fonts
*                         REVIEWED: GuiComboBox(), GuiListView()...
*       1.9 (09-Oct-2018) REVIEWED: GuiGrid(), GuiTextBox(), GuiTextBoxMulti(), GuiValueBox()...
*       1.8 (01-May-2018) Lot of rework and redesign to align with rGuiStyler and rGuiLayout
*       1.5 (21-Jun-2017) Working in an improved styles system
*       1.4 (15-Jun-2017) Rewritten all GUI functions (removed useless ones)
*       1.3 (12-Jun-2017) Complete redesign of style system
*       1.1 (01-Jun-2017) Complete review of the library
*       1.0 (07-Jun-2016) Converted to header-only by Ramon Santamaria.
*       0.9 (07-Mar-2016) Reviewed and tested by Albert Martos, Ian Eito, Sergio Martinez and Ramon Santamaria.
*       0.8 (27-Aug-2015) Initial release. Implemented by Kevin Gato, Daniel Nicolás and Ramon Santamaria.
*
*
*   CONTRIBUTORS:
*
*       Ramon Santamaria:   Supervision, review, redesign, update and maintenance
*       Vlad Adrian:        Complete rewrite of GuiTextBox() to support extended features (2019)
*       Sergio Martinez:    Review, testing (2015) and redesign of multiple controls (2018)
*       Adria Arranz:       Testing and Implementation of additional controls (2018)
*       Jordi Jorba:        Testing and Implementation of additional controls (2018)
*       Albert Martos:      Review and testing of the library (2015)
*       Ian Eito:           Review and testing of the library (2015)
*       Kevin Gato:         Initial implementation of basic components (2014)
*       Daniel Nicolas:     Initial implementation of basic components (2014)
*
*
*   LICENSE: zlib/libpng
*
*   Copyright (c) 2014-2022 Ramon Santamaria (@raysan5)
*
*   This software is provided "as-is", without any express or implied warranty. In no event
*   will the authors be held liable for any damages arising from the use of this software.
*
*   Permission is granted to anyone to use this software for any purpose, including commercial
*   applications, and to alter it and redistribute it freely, subject to the following restrictions:
*
*     1. The origin of this software must not be misrepresented; you must not claim that you
*     wrote the original software. If you use this software in a product, an acknowledgment
*     in the product documentation would be appreciated but is not required.
*
*     2. Altered source versions must be plainly marked as such, and must not be misrepresented
*     as being the original software.
*
*     3. This notice may not be removed or altered from any source distribution.
*
**********************************************************************************************/

// NOTE(pJotoro): Bindings fo raygui do not work at all right now because raylib.lib does not contain raygui.

using System;

namespace Raylib.Gui
{
	static
	{
		public const char8* VERSION = "3.1";
	}

	// Style property
	[CRepr]
	struct StyleProp
	{
	    public uint16 controlId;
	    public uint16 propertyId;
	    public int32 propertyValue;
	}

	// Gui control state
	enum ControlState : int32
	{
	    NORMAL = 0,
	    FOCUSED,
	    PRESSED,
	    DISABLED,
	}

	// Gui control text alignment
	enum TextAlignment : int32
	{
	    LEFT = 0,
	    CENTER,
	    RIGHT,
	}

	// Gui controls
	enum Control : int32
	{
	    DEFAULT = 0,    // Generic control -> populates to all controls when set
	    LABEL,          // Used also for: LABELBUTTON
	    BUTTON,
	    TOGGLE,         // Used also for: TOGGLEGROUP
	    SLIDER,         // Used also for: SLIDERBAR
	    PROGRESSBAR,
	    CHECKBOX,
	    COMBOBOX,
	    DROPDOWNBOX,
	    TEXTBOX,        // Used also for: TEXTBOXMULTI
	    VALUEBOX,
	    SPINNER,
	    LISTVIEW,
	    COLORPICKER,
	    SCROLLBAR,
	    STATUSBAR
	}

	// Gui base properties for every control
	// NOTE: RAYGUI_MAX_PROPS_BASE properties (by default 16 properties)
	enum ControlProperty : int32
	{
	    BORDER_COLOR_NORMAL = 0,
	    BASE_COLOR_NORMAL,
	    TEXT_COLOR_NORMAL,
	    BORDER_COLOR_FOCUSED,
	    BASE_COLOR_FOCUSED,
	    TEXT_COLOR_FOCUSED,
	    BORDER_COLOR_PRESSED,
	    BASE_COLOR_PRESSED,
	    TEXT_COLOR_PRESSED,
	    BORDER_COLOR_DISABLED,
	    BASE_COLOR_DISABLED,
	    TEXT_COLOR_DISABLED,
	    BORDER_WIDTH,
	    TEXT_PADDING,
	    TEXT_ALIGNMENT,
	    RESERVED
	}

	// Gui extended properties depend on control
	// NOTE: RAYGUI_MAX_PROPS_EXTENDED properties (by default 8 properties)

	// DEFAULT extended properties
	// NOTE: Those properties are actually common to all controls
	enum DefaultProperty : int32
	{
	    TEXT_SIZE = 16,
	    TEXT_SPACING,
	    LINE_COLOR,
	    BACKGROUND_COLOR,
	}

	// Toggle/ToggleGroup
	enum ToggleProperty : int32
	{
	    GROUP_PADDING = 16,
	}

	// Slider/SliderBar
	enum SliderProperty : int32
	{
	    WIDTH = 16,
	    PADDING
	}

	// ProgressBar
	enum ProgressBarProperty : int32
	{
	    PROGRESS_PADDING = 16,
	}

	// CheckBox
	enum CheckBoxProperty : int32
	{
	    CHECK_PADDING = 16
	}

	// ComboBox
	enum ComboBoxProperty: int32
	{
	    COMBO_BUTTON_WIDTH = 16,
	    COMBO_BUTTON_PADDING
	}

	// DropdownBox
	enum DropdownBoxProperty : int32
	{
	    ARROW_PADDING = 16,
	    DROPDOWN_ITEMS_PADDING
	}

	// TextBox/TextBoxMulti/ValueBox/Spinner
	enum TextBoxProperty : int32
	{
	    TEXT_INNER_PADDING = 16,
	    TEXT_LINES_PADDING,
	    COLOR_SELECTED_FG,
	    COLOR_SELECTED_BG
	}

	// Spinner
	enum SpinnerProperty : int32
	{
	    SPIN_BUTTON_WIDTH = 16,
	    SPIN_BUTTON_PADDING,
	}

	// ScrollBar
	enum ScrollBarProperty : int32
	{
	    ARROWS_SIZE = 16,
	    ARROWS_VISIBLE,
	    SCROLL_SLIDER_PADDING,
	    SCROLL_SLIDER_SIZE,
	    SCROLL_PADDING,
	    SCROLL_SPEED,
	}

	// ScrollBar side
	enum ScrollBarSide : int32
	{
	    SCROLLBAR_LEFT_SIDE = 0,
	    SCROLLBAR_RIGHT_SIDE
	}

	// ListView
	enum ListViewProperty : int32
	{
	    LIST_ITEMS_HEIGHT = 16,
	    LIST_ITEMS_PADDING,
	    SCROLLBAR_WIDTH,
	    SCROLLBAR_SIDE,
	}

	// ColorPicker
	enum ColorPickerProperty : int32
	{
	    COLOR_SELECTOR_SIZE = 16,
	    HUEBAR_WIDTH,                  // Right hue bar width
	    HUEBAR_PADDING,                // Right hue bar separation from panel
	    HUEBAR_SELECTOR_HEIGHT,        // Right hue bar selector height
	    HUEBAR_SELECTOR_OVERFLOW       // Right hue bar selector overflow
	}

	//----------------------------------------------------------------------------------
	// Global Variables Definition
	//----------------------------------------------------------------------------------
	// ...

	//----------------------------------------------------------------------------------
	// Module Functions Declaration
	//----------------------------------------------------------------------------------

	static
	{
		// Global gui state control functions
		[LinkName("GuiEnable")]
		public static extern void Enable();                                         // Enable gui controls (global state)
		[LinkName("GuiDisable")]
		public static extern void Disable();                                        // Disable gui controls (global state)
		[LinkName("GuiLock")]
		public static extern void Lock();                                           // Lock gui controls (global state)
		[LinkName("GuiUnlock")]
		public static extern void Unlock();                                         // Unlock gui controls (global state)
		[LinkName("GuiIsLocked")]
		public static extern bool IsLocked();                                       // Check if gui is locked (global state)
		[LinkName("GuiFade")]
		public static extern void Fade(float alpha);                                    // Set gui controls alpha (global state), alpha goes from 0.0f to 1.0f
		[LinkName("GuiSetState")]
		public static extern void SetState(int32 state);                                  // Set gui state (global state)
		[LinkName("GuiGetState")]
		public static extern int32 GetState();                                        // Get gui state (global state)

		// Font set/get functions
		[LinkName("GuiSetFont")]
		public static extern void SetFont(Font font);                                   // Set gui custom font (global state)
		[LinkName("GuiGetFont")]
		public static extern Font GetFont();                                        // Get gui custom font (global state)

		// Style set/get functions
		[LinkName("GuiSetStyle")]
		public static extern void SetStyle(int32 control, int32 property, int32 value);       // Set one style property
		[LinkName("GuiGetStyle")]
		public static extern int32 GetStyle(int32 control, int32 property);                   // Get one style property

		// Container/separator controls, useful for controls organization
		[LinkName("GuiWindowBox")]
		public static extern bool WindowBox(Rectangle bounds, char8* title);                                       // Window Box control, shows a window that can be closed
		[LinkName("GuiGroupBox")]
		public static extern void GroupBox(Rectangle bounds, char8* text);                                         // Group Box control with text name
		[LinkName("GuiLine")]
		public static extern void Line(Rectangle bounds, char8* text);                                             // Line separator control, could contain text
		[LinkName("GuiPanel")]
		public static extern void Panel(Rectangle bounds);                                                              // Panel control, useful to group controls
		[LinkName("GuiScrollPanel")]
		public static extern Rectangle ScrollPanel(Rectangle bounds, Rectangle content, Vector2* scroll);               // Scroll Panel control

		// Basic controls set
		[LinkName("GuiLabel")]
		public static extern void Label(Rectangle bounds, char8* text);                                            // Label control, shows text
		[LinkName("GuiButton")]
		public static extern bool Button(Rectangle bounds, char8* text);                                           // Button control, returns true when clicked
		[LinkName("GuiLabelButton")]
		public static extern bool LabelButton(Rectangle bounds, char8* text);                                      // Label button control, show true when clicked
		[LinkName("GuiToggle")]
		public static extern bool Toggle(Rectangle bounds, char8* text, bool active);                              // Toggle Button control, returns true when active
		[LinkName("GuiToggleGroup")]
		public static extern int ToggleGroup(Rectangle bounds, char8* text, int32 active);                           // Toggle Group control, returns active toggle index
		[LinkName("GuiCheckBox")]
		public static extern bool CheckBox(Rectangle bounds, char8* text, bool checked_);                           // Check Box control, returns true when active
		[LinkName("GuiComboBox")]
		public static extern int ComboBox(Rectangle bounds, char8* text, int32 active);                              // Combo Box control, returns selected item index
		[LinkName("GuiDropdownBox")]
		public static extern bool DropdownBox(Rectangle bounds, char8* text, int32* active, bool editMode);          // Dropdown Box control, returns selected item
		[LinkName("GuiSpinner")]
		public static extern bool Spinner(Rectangle bounds, char8* text, int32* value, int32 minValue, int32 maxValue, bool editMode);     // Spinner control, returns selected value
		[LinkName("GuiValueBox")]
		public static extern bool ValueBox(Rectangle bounds, char8* text, int32* value, int32 minValue, int32 maxValue, bool editMode);    // Value Box control, updates input text with numbers
		[LinkName("GuiTextBox")]
		public static extern bool TextBox(Rectangle bounds, char8* text, int32 textSize, bool editMode);                   // Text Box control, updates input text
		[LinkName("GuiTextBoxMulti")]
		public static extern bool TextBoxMulti(Rectangle bounds, char8* text, int32 textSize, bool editMode);              // Text Box control with multiple lines
		[LinkName("GuiSlider")]
		public static extern float Slider(Rectangle bounds, char8* textLeft, char8* textRight, float value, float minValue, float maxValue);       // Slider control, returns selected value
		[LinkName("GuiSliderBar")]
		public static extern float SliderBar(Rectangle bounds, char8* textLeft, char8* textRight, float value, float minValue, float maxValue);    // Slider Bar control, returns selected value
		[LinkName("GuiProgressBar")]
		public static extern float ProgressBar(Rectangle bounds, char8* textLeft, char8* textRight, float value, float minValue, float maxValue);  // Progress Bar control, shows current progress value
		[LinkName("GuiStatusBar")]
		public static extern void StatusBar(Rectangle bounds, char8* text);                                        // Status Bar control, shows info text
		[LinkName("GuiDummyRec")]
		public static extern void DummyRec(Rectangle bounds, char8* text);                                         // Dummy control for placeholders
		[LinkName("GuiScrollBar")]
		public static extern int32 ScrollBar(Rectangle bounds, int32 value, int32 minValue, int32 maxValue);                    // Scroll Bar control
		[LinkName("GuiGrid")]
		public static extern Vector2 Grid(Rectangle bounds, float spacing, int32 subdivs);                                // Grid control


		// Advance controls set
		[LinkName("GuiListView")]
		public static extern int32 ListView(Rectangle bounds, char8* text, int32* scrollIndex, int32 active);            // List View control, returns selected list item index
		[LinkName("GuiListViewEx")]
		public static extern int32 ListViewEx(Rectangle bounds, char8* *text, int32 count, int32* focus, int32* scrollIndex, int32 active);      // List View with extended parameters
		[LinkName("GuiMessageBox")]
		public static extern int32 MessageBox(Rectangle bounds, char8* title, char8* message, char8* buttons);                 // Message Box control, displays a message
		[LinkName("GuiTextInputBox")]
		public static extern int32 TextInputBox(Rectangle bounds, char8* title, char8* message, char8* buttons, char8* text);   // Text Input Box control, ask for text
		[LinkName("GuiColorPicker")]
		public static extern Color ColorPicker(Rectangle bounds, Color color);                                          // Color Picker control (multiple color controls)
		[LinkName("GuiColorPanel")]
		public static extern Color ColorPanel(Rectangle bounds, Color color);                                           // Color Panel control
		[LinkName("GuiColorBarAlpha")]
		public static extern float ColorBarAlpha(Rectangle bounds, float alpha);                                        // Color Bar Alpha control
		[LinkName("GuiColorBarHue")]
		public static extern float ColorBarHue(Rectangle bounds, float value);                                          // Color Bar Hue control

		// Styles loading functions
		[LinkName("GuiLoadStyle")]
		public static extern void LoadStyle(char8* fileName);              // Load style file over global style variable (.rgs)
		[LinkName("GuiLoadStyleDefault")]
		public static extern void LoadStyleDefault();                       // Load style default over global style

		/*
		typedef GuiStyle (unsigned int *)
		public static extern GuiStyle LoadGuiStyle(char8* fileName);          // Load style from file (.rgs)
		public static extern void UnloadGuiStyle(GuiStyle style);                  // Unload style
		*/

		[LinkName("GuiIconText")]
		public static extern char8* IconText(int32 iconId, char8* text); // Get text with icon id prepended (if supported)

		// Gui icons functionality
		[LinkName("GuiDrawIcon")]
		public static extern void DrawIcon(int32 iconId, int32 posX, int32 posY, int32 pixelSize, Color color);

		[LinkName("GuiGetIcons")]
		public static extern uint32* GetIcons();                      // Get full icons data pointer
		[LinkName("GuiGetIconData")]
		public static extern uint32* GetIconData(int32 iconId);             // Get icon bit data
		[LinkName("GuiSetIconData")]
		public static extern void SetIconData(int32 iconId, uint32* data);  // Set icon bit data

		[LinkName("GuiSetIconPixel")]
		public static extern void SetIconPixel(int32 iconId, int32 x, int32 y);       // Set icon pixel value
		[LinkName("GuiClearIconPixel")]
		public static extern void ClearIconPixel(int32 iconId, int32 x, int32 y);     // Clear icon pixel value
		[LinkName("GuiCheckIconPixel")]
		public static extern bool CheckIconPixel(int32 iconId, int32 x, int32 y);     // Check icon pixel value
	}
}