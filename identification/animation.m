close all;
figure;
gif('temp2.gif');
% gif('frame', gca);
heights=0:1:20;
heights=heights*2.5;
d=20;
duration=20;
freq=10;
t=linspace(0,t0(end), duration*freq);
xspace0=interp1(t0, y0(:,1:20),t);
xspace0=[zeros(length(t), 1), xspace0];
xspace0=50*xspace0;
t=linspace(0,t0(end), duration*freq);
xspace1=interp1(t1, y1(:,1:20),t);
xspace1=[zeros(length(t), 1), xspace1];
xspace1=50*xspace1;
limits=[min(min(min(xspace0)), min(min(xspace1))), max(max(max(xspace0)), max(max(xspace1)))];
xbound=1.5*[-d-limits(2)+limits(1), d+limits(2)-limits(1)];
for i=1:1:length(t)
    tic;
    defl0=interp1(heights, xspace0(i, :), linspace(0, heights(end), 100), 'pchip');
    plot(defl0-d+xbound(1)+1/3*(xbound(2)-xbound(1)),linspace(0, heights(end), 100),'LineWidth',5);
    xlim(xbound);
    
    hold on;
    plot(defl0+d+xbound(1)+1/3*(xbound(2)-xbound(1)),linspace(0, heights(end), 100), 'LineWidth',5);
%     defl1=interp1(heights, xspace1(i, :), linspace(0, heights(end), 100), 'pchip');
%     plot(defl1-d+xbound(1)+2/3*(xbound(2)-xbound(1)),linspace(0, heights(end), 100), 'LineWidth',5);
%     plot(defl1+d+xbound(1)+2/3*(xbound(2)-xbound(1)),linspace(0, heights(end), 100), 'LineWidth',5);
    for j=1:1:20
        plot([xspace0(i, j+1)-d+xbound(1)+1/3*(xbound(2)-xbound(1)),xspace0(i, j+1)+d+xbound(1)+1/3*(xbound(2)-xbound(1))], [heights(j+1),heights(j+1)], '-b', 'LineWidth', 5);
    end
%     for j=1:1:20
%         plot([xspace1(i, j+1)-d+xbound(1)+2/3*(xbound(2)-xbound(1)),xspace1(i, j+1)+d+xbound(1)+2/3*(xbound(2)-xbound(1))], [heights(j+1),heights(j+1)], '-r', 'LineWidth',5);
%     end
    
    pause(0.01);
    a=gca;
    edges1=a.Children(end-1:end);
    for k=1:1:length(edges1)
        set(edges1(k).Edge, 'ColorBinding','interpolated', 'ColorData',uint8([interp1(linspace(0,max(abs(limits)),10), 255*[linspace(0,1,10); linspace(1,0,10); zeros(1,10)]', abs(edges1(k).XData-edges1(k).XData(1)), 'pchip', max(abs(limits))), ones(100,1)]'));
        %         disp(edges1(k).XData(1));
    end
    edges2=a.Children(20:-1:1);
    for k=1:1:length(edges2)
        set(edges2(k), 'Color',(interp1(linspace(0,max(abs(limits)),10), [linspace(0,1,10); linspace(1,0,10); zeros(1,10)]', abs(xspace0(i, k)), 'pchip', max(abs(limits)))));
        %         set(edges2(k), 'Color',[1 0 0]);
    end
%     edges3=a.Children(20:-1:1);
%     for k=1:1:length(edges3)
%         set(edges3(k), 'Color',(interp1(linspace(0,max(abs(limits)),10), [linspace(0,1,10); linspace(1,0,10); zeros(1,10)]', abs(xspace1(i, k)), 'pchip', max(abs(limits)))));
%         %         set(edges2(k), 'Color',[1 0 0]);
%     end
    drawnow;
    %     edges2=a.Children(39);
    %     for k=1:1:length(edges2)
    %         set(edges2(k), 'Color','black');
    %                 set(edges2(k), 'Color',[1 0 0]);
    %     end
    hold off;
    while toc<1/freq
        
    end
    gif
end

