#ifndef VIEW_LAYOUT_H
#define VIEW_LAYOUT_H

class View;

class ViewLayout
{
public:
	ViewLayout();
	virtual ~ViewLayout();

	virtual void addView(View* view) = 0;
	virtual void removeView(View* view) = 0;

	virtual void loadLayout() = 0;
	virtual void saveLayout() = 0;
};

#endif // VIEW_LAYOUT_H
