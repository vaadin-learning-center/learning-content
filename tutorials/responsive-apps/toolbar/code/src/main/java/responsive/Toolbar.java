package responsive;

import com.vaadin.flow.component.button.Button;
import com.vaadin.flow.component.contextmenu.ContextMenu;
import com.vaadin.flow.component.html.Span;
import com.vaadin.flow.component.icon.Icon;
import com.vaadin.flow.component.icon.VaadinIcon;
import com.vaadin.flow.component.orderedlayout.HorizontalLayout;

public class Toolbar extends HorizontalLayout {

	private String CLASS_NAME = "toolbar";

	public Toolbar() {
		addClassName(CLASS_NAME);
		setAlignItems(Alignment.CENTER);
		setPadding(true);

		Span title = new Span("Toolbar");

		Button bold = new Button(new Icon(VaadinIcon.BOLD));
		Button italic = new Button(new Icon(VaadinIcon.ITALIC));
		Button underline = new Button(new Icon(VaadinIcon.UNDERLINE));
		Button left = new Button(new Icon(VaadinIcon.ALIGN_LEFT));
		Button center = new Button(new Icon(VaadinIcon.ALIGN_CENTER));
		Button right = new Button(new Icon(VaadinIcon.ALIGN_RIGHT));
		Button justify = new Button(new Icon(VaadinIcon.ALIGN_JUSTIFY));

		Button overflow = new Button(new Icon(VaadinIcon.ELLIPSIS_DOTS_V));
		overflow.addClassName("overflow");

		ContextMenu menu = new ContextMenu();
		menu.setTarget(overflow);
		menu.setOpenOnClick(true);
		menu.addItem("Bold", null);
		menu.addItem("Italic", null);
		menu.addItem("Underline", null);
		menu.addItem("Left", null);
		menu.addItem("Center", null);
		menu.addItem("Right", null);
		menu.addItem("Justify", null);

		add(title, bold, italic, underline, left, center, right, justify, overflow);
		setFlexGrow(1, title);
	}

}
