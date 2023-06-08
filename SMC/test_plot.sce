clf()
x=0:0.01:6*%pi;
plot2d(x,sin(x.^2))
zoom_rect([16,-1,18,1])
//more zoom
zoom_rect([16,0,16.2,1])
//back to the original
unzoom()
// zooming using axes_properties
a=gca();
a.zoom_box=[16,0,16.2,1];
a.zoom_box=[];

//zooming subplots accordingly
clf()
x=0:0.01:6*%pi;
subplot(211)
plot2d(x,cos(x))
subplot(212)
plot2d(x,cos(2*x))
rect=[3 -2 7 10]; //a rectangle specified in the current axes (last one) coordinates
zoom_rect(rect)
unzoom()
//set the global underlying axes as current
f=gcf();set('current_axes',f.children($))
rect=[0.4 0 0.6 1] //a rectangle specified in ratio of the window size
zoom_rect(rect)
rect=[0.4 0.2 0.6 0.8]; //a rectangle specified in ratio of the window size
zoom_rect(rect)

// interactive zoom on current figure
//zoom_rect();
//// or
//zoom_rect(gcf());
