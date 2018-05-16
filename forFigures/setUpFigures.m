f=gcf;
aspectRatio=16/9;
ax=gca;
f;
width=9;
f.Units='centimeters';
f.Position=[f.Position(1),f.Position(2), width, width/aspectRatio];
f.Renderer='painter';
f.Units='pixels';

lineWidth=0.8;
for i=1:1:length(ax.Children)
    if class(ax.Children(i))==matlab.graphics.chart.primitive.Line
        ax.Children(i).LineWidth=lineWidth;
    end
end
ax.Units='pixels';
ax.Position=[0+ax.TightInset(1)+2, 0+ax.TightInset(2)+2, f.Position(3)-ax.TightInset(1)-ax.TightInset(3)-2, f.Position(4)-ax.TightInset(2)-ax.TightInset(4)-2];
% outerpos = ax.OuterPosition;
% ti = ax.TightInset;
% left =-0.2 ;
% bottom = ti(2);
% ax_width =1.4;
% ax_height =1-ti(2)-ti(4);
% ax.Position = [left bottom ax_width ax_height];