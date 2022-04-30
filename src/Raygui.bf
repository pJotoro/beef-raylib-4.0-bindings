using System;

namespace Raylib.Gui
{
	static
	{
		public const char8* VERSION = "3.0";
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
		public static extern Rectangle ScrollPanel(Rectangle bounds, Rectangle content, Vector2 *scroll);               // Scroll Panel control

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