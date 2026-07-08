%% cooperative control second order
close all;
clear;
clc;

load('matlab.mat')
img = imread('mapnew2.png');
img=flipud(img);

%% dimensions
[n,m] = size(Incidence_Matrix'); % n is the number of the followers
                                 % m is the number of the edges
% edge set
edge = mod(reshape(find((Incidence_Matrix')~=0),2,m),n);
edge(edge==0) = n;
%% 画小船
l1=1.5;l2=1.5;
xF = [0,0,0,0,0;0,0,0,0,0;0,0,0,0,0;0,0,0,0,0;]';%5*4
yF = [0,0,0,0,0;0,0,0,0,0;0,0,0,0,0;0,0,0,0,0;]';%5*4
xL = [0,0,0,0,0;0,0,0,0,0;0,0,0,0,0]';%5*3
yL = [0,0,0,0,0;0,0,0,0,0;0,0,0,0,0]';%5*3 

%% result
figure(4)   
      image('CData',img,'XData',[-50 450],'YData',[0 400])
      hold on
%     plot(xpos_data(1,:),ypos_data(1,:),'-.','Color', 'k','linewidth',1); hold on
%     plot(xpos_data(2,:),ypos_data(2,:),'-.','Color', 'k','linewidth',1); hold on
%     plot(xpos_data(3,:),ypos_data(3,:),'-.','Color', 'k','linewidth',1); hold on
%     
%     plot(x_f(1,:),y_f(1,:),'--','Color', '#D95319','linewidth',1); hold on%红
%     plot(x_f(2,:),y_f(2,:),'--','Color', '#00C78C','linewidth',1); hold on%绿
%     plot(x_f(3,:),y_f(3,:),'--','Color', '#DDA0DD','linewidth',1); hold on%粉色
%     plot(x_f(4,:),y_f(4,:),'--','Color', '#DAA520','linewidth',1); hold on%黄色
    
    plot(all_eta_L(1,:,1),all_eta_L(2,:,1),'--','Color', '#0072BD','linewidth',1); hold on%蓝
    plot(all_eta_L(1,:,2),all_eta_L(2,:,2),'--','Color', '#00FFFF','linewidth',1); hold on%青
    plot(all_eta_L(1,:,3),all_eta_L(2,:,3),'--','Color', '#9400D3','linewidth',1); hold on%紫
    
    plot(all_eta_F(1,:,1),all_eta_F(2,:,1),'--','Color', '#D95319','linewidth',1); hold on%红
    plot(all_eta_F(1,:,2),all_eta_F(2,:,2),'--','Color', '#006400','linewidth',1); hold on%绿
    plot(all_eta_F(1,:,3),all_eta_F(2,:,3),'--','Color', '#DDA0DD','linewidth',1); hold on%粉
    plot(all_eta_F(1,:,4),all_eta_F(2,:,4),'--','Color', '#DAA520','linewidth',1); hold on%黄
%     xlabel('East[m]','FontSize',10,'FontName','Palatino Linotype');
%     ylabel('North[m]','FontSize',10,'FontName','Palatino Linotype'); hold on;
    xlabel('east[m]','FontSize',10.5,'FontName','宋体');
    ylabel('west[m]','FontSize',10.5,'FontName','宋体'); hold on;
    axis([-80,450,-80,400]);
    set(gca,'Xtick',[-50:50:450]);
    set(gca,'Ytick',[-50:50:400]);
    w=legend('leader1','leader2','leader3','follower4','follower5','follower6', 'follower7');
    set(w,'Position',[0.66032356163954 0.682044355204635 0.146739133129949 0.1452164041697],...
        'Orientation','vertical','FontSize',10.5, 'FontName','Times NewRoman', 'AutoUpdate','off');
    w.ItemTokenSize = [15,15];hold on;
%     w=legend('Leader1','Leader2','Leader3','Follower4','Follower5','Follower6', 'Follower7');
%     set(w,'Position',[0.66032356163954 0.682044355204635 0.146739133129949 0.1452164041697],...
%         'Orientation','vertical','FontSize',10, 'FontName','Palatino Linotype', 'AutoUpdate','off');
    w.ItemTokenSize = [15,15];hold on;
%% 第一个队形
o=1;
        new_eta_1 = [  all_eta_L(1,o,1),all_eta_L(2,o,1);
                       all_eta_L(1,o,2),all_eta_L(2,o,2);
                       all_eta_L(1,o,3),all_eta_L(2,o,3);
                       all_eta_F(1,o,1),all_eta_F(2,o,1);
                       all_eta_F(1,o,2),all_eta_F(2,o,2);
                       all_eta_F(1,o,3),all_eta_F(2,o,3);
                       all_eta_F(1,o,4),all_eta_F(2,o,4)];   
       for i=1:m
           plot(new_eta_1(edge(:,i),1),new_eta_1(edge(:,i),2),'Color','K','linewidth',1); hold on;
       end
        for i=1:3
          	xL(1,i)=all_eta_L(1,o,i)+l1*sin(0)+l2*cos(0);
            xL(2,i)=all_eta_L(1,o,i)+l1*sin(0)-l2*cos(0);
            xL(3,i)=all_eta_L(1,o,i)-l1*sin(0)-l2*cos(0);
            xL(4,i)=all_eta_L(1,o,i)-l1*sin(0)+l2*cos(0);
            xL(5,i)=all_eta_L(1,o,i)+(l2+1.7*l1)*cos(0);

            yL(1,i)=all_eta_L(2,o,i)-l1*cos(0)+l2*sin(0);
            yL(2,i)=all_eta_L(2,o,i)-l1*cos(0)-l2*sin(0);
            yL(3,i)=all_eta_L(2,o,i)+l1*cos(0)-l2*sin(0);
            yL(4,i)=all_eta_L(2,o,i)+l1*cos(0)+l2*sin(0);
            yL(5,i)=all_eta_L(2,o,i)+(l2+1.7*l1)*sin(0);
        end
            XL1=[xL(1,1),xL(2,1),xL(3,1),xL(4,1),xL(5,1),xL(1,1)];
            YL1=[yL(1,1),yL(2,1),yL(3,1),yL(4,1),yL(5,1),yL(1,1)];        
            plot(XL1,YL1,'Color','#0072BD'),axis equal  
            fill(XL1,YL1,[0,114,189]/255);
            XL2=[xL(1,2),xL(2,2),xL(3,2),xL(4,2),xL(5,2),xL(1,2)];
            YL2=[yL(1,2),yL(2,2),yL(3,2),yL(4,2),yL(5,2),yL(1,2)];        
            plot(XL2,YL2,'Color','#00FFFF'),axis equal  
            fill(XL2,YL2,[0,255,255]/255);
            XL3=[xL(1,3),xL(2,3),xL(3,3),xL(4,3),xL(5,3),xL(1,3)];
            YL3=[yL(1,3),yL(2,3),yL(3,3),yL(4,3),yL(5,3),yL(1,3)];        
            plot(XL3,YL3,'Color','#9400D3'),axis equal  
            fill(XL3,YL3,[148,0,211]/255);
       for i=1:4
          	xF(1,i)=all_eta_F(1,o,i)+l1*sin(0)+l2*cos(0);
            xF(2,i)=all_eta_F(1,o,i)+l1*sin(0)-l2*cos(0);
            xF(3,i)=all_eta_F(1,o,i)-l1*sin(0)-l2*cos(0);
            xF(4,i)=all_eta_F(1,o,i)-l1*sin(0)+l2*cos(0);
            xF(5,i)=all_eta_F(1,o,i)+(l2+1.7*l1)*cos(0);

            yF(1,i)=all_eta_F(2,o,i)-l1*cos(0)+l2*sin(0);
            yF(2,i)=all_eta_F(2,o,i)-l1*cos(0)-l2*sin(0);
            yF(3,i)=all_eta_F(2,o,i)+l1*cos(0)-l2*sin(0);
            yF(4,i)=all_eta_F(2,o,i)+l1*cos(0)+l2*sin(0);
            yF(5,i)=all_eta_F(2,o,i)+(l2+1.7*l1)*sin(0);
       end
            XF1=[xF(1,1),xF(2,1),xF(3,1),xF(4,1),xF(5,1),xF(1,1)];
            YF1=[yF(1,1),yF(2,1),yF(3,1),yF(4,1),yF(5,1),yF(1,1)];        
            plot(XF1,YF1,'Color','#D95319'),axis equal  
            fill(XF1,YF1,[0.85, 0.32, 0.098]);
            XF2=[xF(1,2),xF(2,2),xF(3,2),xF(4,2),xF(5,2),xF(1,2)];
            YF2=[yF(1,2),yF(2,2),yF(3,2),yF(4,2),yF(5,2),yF(1,2)];        
            plot(XF2,YF2,'Color', '#00C78C'),axis equal  
            fill(XF2,YF2,[0,199,140]/255);
            XF3=[xF(1,3),xF(2,3),xF(3,3),xF(4,3),xF(5,3),xF(1,3)];
            YF3=[yF(1,3),yF(2,3),yF(3,3),yF(4,3),yF(5,3),yF(1,3)];        
            plot(XF3,YF3,'Color', '#DDA0DD'),axis equal  
            fill(XF3,YF3,[221,160,221]/255);
            XF4=[xF(1,4),xF(2,4),xF(3,4),xF(4,4),xF(5,4),xF(1,4)];
            YF4=[yF(1,4),yF(2,4),yF(3,4),yF(4,4),yF(5,4),yF(1,4)];        
            plot(XF4,YF4,'Color', '#DAA520'),axis equal  
            fill(XF4,YF4,[218,165,32]/255);
%% 第二个队形
o=6800;
        new_eta_1 = [  all_eta_L(1,o,1),all_eta_L(2,o,1);
                       all_eta_L(1,o,2),all_eta_L(2,o,2);
                       all_eta_L(1,o,3),all_eta_L(2,o,3);
                       all_eta_F(1,o,1),all_eta_F(2,o,1);
                       all_eta_F(1,o,2),all_eta_F(2,o,2);
                       all_eta_F(1,o,3),all_eta_F(2,o,3);
                       all_eta_F(1,o,4),all_eta_F(2,o,4)];   
       for i=1:m
           plot(new_eta_1(edge(:,i),1),new_eta_1(edge(:,i),2),'Color','K','linewidth',1); hold on;
       end
        for i=1:3
          	xL(1,i)=all_eta_L(1,o,i)+l1*sin(-pi/4)+l2*cos(-pi/4);
            xL(2,i)=all_eta_L(1,o,i)+l1*sin(-pi/4)-l2*cos(-pi/4);
            xL(3,i)=all_eta_L(1,o,i)-l1*sin(-pi/4)-l2*cos(-pi/4);
            xL(4,i)=all_eta_L(1,o,i)-l1*sin(-pi/4)+l2*cos(-pi/4);
            xL(5,i)=all_eta_L(1,o,i)+(l2+1.7*l1)*cos(-pi/4);

            yL(1,i)=all_eta_L(2,o,i)-l1*cos(-pi/4)+l2*sin(-pi/4);
            yL(2,i)=all_eta_L(2,o,i)-l1*cos(-pi/4)-l2*sin(-pi/4);
            yL(3,i)=all_eta_L(2,o,i)+l1*cos(-pi/4)-l2*sin(-pi/4);
            yL(4,i)=all_eta_L(2,o,i)+l1*cos(-pi/4)+l2*sin(-pi/4);
            yL(5,i)=all_eta_L(2,o,i)+(l2+1.7*l1)*sin(-pi/4);
        end
            XL1=[xL(1,1),xL(2,1),xL(3,1),xL(4,1),xL(5,1),xL(1,1)];
            YL1=[yL(1,1),yL(2,1),yL(3,1),yL(4,1),yL(5,1),yL(1,1)];        
            plot(XL1,YL1,'Color','#D95319'),axis equal  
            fill(XL1,YL1,[0,114,189]/255);
            XL2=[xL(1,2),xL(2,2),xL(3,2),xL(4,2),xL(5,2),xL(1,2)];
            YL2=[yL(1,2),yL(2,2),yL(3,2),yL(4,2),yL(5,2),yL(1,2)];        
            plot(XL2,YL2,'Color','#00FFFF'),axis equal  
            fill(XL2,YL2,[0,255,255]/255);
            XL3=[xL(1,3),xL(2,3),xL(3,3),xL(4,3),xL(5,3),xL(1,3)];
            YL3=[yL(1,3),yL(2,3),yL(3,3),yL(4,3),yL(5,3),yL(1,3)];        
            plot(XL3,YL3,'Color','#9400D3'),axis equal  
            fill(XL3,YL3,[148,0,211]/255);
       for i=1:4
          	xF(1,i)=all_eta_F(1,o,i)+l1*sin(-pi/4)+l2*cos(-pi/4);
            xF(2,i)=all_eta_F(1,o,i)+l1*sin(-pi/4)-l2*cos(-pi/4);
            xF(3,i)=all_eta_F(1,o,i)-l1*sin(-pi/4)-l2*cos(-pi/4);
            xF(4,i)=all_eta_F(1,o,i)-l1*sin(-pi/4)+l2*cos(-pi/4);
            xF(5,i)=all_eta_F(1,o,i)+(l2+1.7*l1)*cos(-pi/4);

            yF(1,i)=all_eta_F(2,o,i)-l1*cos(-pi/4)+l2*sin(-pi/4);
            yF(2,i)=all_eta_F(2,o,i)-l1*cos(-pi/4)-l2*sin(-pi/4);
            yF(3,i)=all_eta_F(2,o,i)+l1*cos(-pi/4)-l2*sin(-pi/4);
            yF(4,i)=all_eta_F(2,o,i)+l1*cos(-pi/4)+l2*sin(-pi/4);
            yF(5,i)=all_eta_F(2,o,i)+(l2+1.7*l1)*sin(-pi/4);
       end
            XF1=[xF(1,1),xF(2,1),xF(3,1),xF(4,1),xF(5,1),xF(1,1)];
            YF1=[yF(1,1),yF(2,1),yF(3,1),yF(4,1),yF(5,1),yF(1,1)];        
            plot(XF1,YF1,'Color','#D95319'),axis equal  
            fill(XF1,YF1,[0.85, 0.32, 0.098]);
            XF2=[xF(1,2),xF(2,2),xF(3,2),xF(4,2),xF(5,2),xF(1,2)];
            YF2=[yF(1,2),yF(2,2),yF(3,2),yF(4,2),yF(5,2),yF(1,2)];        
            plot(XF2,YF2,'Color', '#00C78C'),axis equal  
            fill(XF2,YF2,[0,199,140]/255);
            XF3=[xF(1,3),xF(2,3),xF(3,3),xF(4,3),xF(5,3),xF(1,3)];
            YF3=[yF(1,3),yF(2,3),yF(3,3),yF(4,3),yF(5,3),yF(1,3)];        
            plot(XF3,YF3,'Color', '#DDA0DD'),axis equal  
            fill(XF3,YF3,[221,160,221]/255);
            XF4=[xF(1,4),xF(2,4),xF(3,4),xF(4,4),xF(5,4),xF(1,4)];
            YF4=[yF(1,4),yF(2,4),yF(3,4),yF(4,4),yF(5,4),yF(1,4)];        
            plot(XF4,YF4,'Color', '#DAA520'),axis equal  
            fill(XF4,YF4,[218,165,32]/255);          
%% 第三个队形
o=18000;
        new_eta_1 = [  all_eta_L(1,o,1),all_eta_L(2,o,1);
                       all_eta_L(1,o,2),all_eta_L(2,o,2);
                       all_eta_L(1,o,3),all_eta_L(2,o,3);
                       all_eta_F(1,o,1),all_eta_F(2,o,1);
                       all_eta_F(1,o,2),all_eta_F(2,o,2);
                       all_eta_F(1,o,3),all_eta_F(2,o,3);
                       all_eta_F(1,o,4),all_eta_F(2,o,4)];   
       for i=1:m
           plot(new_eta_1(edge(:,i),1),new_eta_1(edge(:,i),2),'Color','K','linewidth',0.8); hold on;
       end
        for i=1:3
          	xL(1,i)=all_eta_L(1,o,i)+l1*sin(-pi/2)+l2*cos(-pi/2);
            xL(2,i)=all_eta_L(1,o,i)+l1*sin(-pi/2)-l2*cos(-pi/2);
            xL(3,i)=all_eta_L(1,o,i)-l1*sin(-pi/2)-l2*cos(-pi/2);
            xL(4,i)=all_eta_L(1,o,i)-l1*sin(-pi/2)+l2*cos(-pi/2);
            xL(5,i)=all_eta_L(1,o,i)+(l2+1.7*l1)*cos(-pi/2);

            yL(1,i)=all_eta_L(2,o,i)-l1*cos(-pi/2)+l2*sin(-pi/2);
            yL(2,i)=all_eta_L(2,o,i)-l1*cos(-pi/2)-l2*sin(-pi/2);
            yL(3,i)=all_eta_L(2,o,i)+l1*cos(-pi/2)-l2*sin(-pi/2);
            yL(4,i)=all_eta_L(2,o,i)+l1*cos(-pi/2)+l2*sin(-pi/2);
            yL(5,i)=all_eta_L(2,o,i)+(l2+1.7*l1)*sin(-pi/2);
        end
            XL1=[xL(1,1),xL(2,1),xL(3,1),xL(4,1),xL(5,1),xL(1,1)];
            YL1=[yL(1,1),yL(2,1),yL(3,1),yL(4,1),yL(5,1),yL(1,1)];        
            plot(XL1,YL1,'Color','#D95319'),axis equal  
            fill(XL1,YL1,[0,114,189]/255);
            XL2=[xL(1,2),xL(2,2),xL(3,2),xL(4,2),xL(5,2),xL(1,2)];
            YL2=[yL(1,2),yL(2,2),yL(3,2),yL(4,2),yL(5,2),yL(1,2)];        
            plot(XL2,YL2,'Color','#00FFFF'),axis equal  
            fill(XL2,YL2,[0,255,255]/255);
            XL3=[xL(1,3),xL(2,3),xL(3,3),xL(4,3),xL(5,3),xL(1,3)];
            YL3=[yL(1,3),yL(2,3),yL(3,3),yL(4,3),yL(5,3),yL(1,3)];        
            plot(XL3,YL3,'Color','#9400D3'),axis equal  
            fill(XL3,YL3,[148,0,211]/255);
       for i=1:4
          	xF(1,i)=all_eta_F(1,o,i)+l1*sin(-pi/2)+l2*cos(-pi/2);
            xF(2,i)=all_eta_F(1,o,i)+l1*sin(-pi/2)-l2*cos(-pi/2);
            xF(3,i)=all_eta_F(1,o,i)-l1*sin(-pi/2)-l2*cos(-pi/2);
            xF(4,i)=all_eta_F(1,o,i)-l1*sin(-pi/2)+l2*cos(-pi/2);
            xF(5,i)=all_eta_F(1,o,i)+(l2+1.7*l1)*cos(-pi/2);

            yF(1,i)=all_eta_F(2,o,i)-l1*cos(-pi/2)+l2*sin(-pi/2);
            yF(2,i)=all_eta_F(2,o,i)-l1*cos(-pi/2)-l2*sin(-pi/2);
            yF(3,i)=all_eta_F(2,o,i)+l1*cos(-pi/2)-l2*sin(-pi/2);
            yF(4,i)=all_eta_F(2,o,i)+l1*cos(-pi/2)+l2*sin(-pi/2);
            yF(5,i)=all_eta_F(2,o,i)+(l2+1.7*l1)*sin(-pi/2);
       end
            XF1=[xF(1,1),xF(2,1),xF(3,1),xF(4,1),xF(5,1),xF(1,1)];
            YF1=[yF(1,1),yF(2,1),yF(3,1),yF(4,1),yF(5,1),yF(1,1)];        
            plot(XF1,YF1,'Color','#D95319'),axis equal  
            fill(XF1,YF1,[0.85, 0.32, 0.098]);
            XF2=[xF(1,2),xF(2,2),xF(3,2),xF(4,2),xF(5,2),xF(1,2)];
            YF2=[yF(1,2),yF(2,2),yF(3,2),yF(4,2),yF(5,2),yF(1,2)];        
            plot(XF2,YF2,'Color', '#00C78C'),axis equal  
            fill(XF2,YF2,[0,199,140]/255);
            XF3=[xF(1,3),xF(2,3),xF(3,3),xF(4,3),xF(5,3),xF(1,3)];
            YF3=[yF(1,3),yF(2,3),yF(3,3),yF(4,3),yF(5,3),yF(1,3)];        
            plot(XF3,YF3,'Color', '#DDA0DD'),axis equal  
            fill(XF3,YF3,[221,160,221]/255);
            XF4=[xF(1,4),xF(2,4),xF(3,4),xF(4,4),xF(5,4),xF(1,4)];
            YF4=[yF(1,4),yF(2,4),yF(3,4),yF(4,4),yF(5,4),yF(1,4)];        
            plot(XF4,YF4,'Color', '#DAA520'),axis equal  
            fill(XF4,YF4,[218,165,32]/255);
%% 第四个队形
o=28800;
        new_eta_1 = [  all_eta_L(1,o,1),all_eta_L(2,o,1);
                       all_eta_L(1,o,2),all_eta_L(2,o,2);
                       all_eta_L(1,o,3),all_eta_L(2,o,3);
                       all_eta_F(1,o,1),all_eta_F(2,o,1);
                       all_eta_F(1,o,2),all_eta_F(2,o,2);
                       all_eta_F(1,o,3),all_eta_F(2,o,3);
                       all_eta_F(1,o,4),all_eta_F(2,o,4)];   
       for i=1:m
           plot(new_eta_1(edge(:,i),1),new_eta_1(edge(:,i),2),'Color','K','linewidth',1); hold on;
       end
        for i=1:3
          	xL(1,i)=all_eta_L(1,o,i)+l1*sin(-pi/6)+l2*cos(-pi/6);
            xL(2,i)=all_eta_L(1,o,i)+l1*sin(-pi/6)-l2*cos(-pi/6);
            xL(3,i)=all_eta_L(1,o,i)-l1*sin(-pi/6)-l2*cos(-pi/6);
            xL(4,i)=all_eta_L(1,o,i)-l1*sin(-5*pi/6)+l2*cos(-pi/6);
            xL(5,i)=all_eta_L(1,o,i)+(l2+1.7*l1)*cos(-pi/6);

            yL(1,i)=all_eta_L(2,o,i)-l1*cos(-pi/6)+l2*sin(-pi/6);
            yL(2,i)=all_eta_L(2,o,i)-l1*cos(-pi/6)-l2*sin(-pi/6);
            yL(3,i)=all_eta_L(2,o,i)+l1*cos(-pi/6)-l2*sin(-pi/6);
            yL(4,i)=all_eta_L(2,o,i)+l1*cos(-pi/6)+l2*sin(-pi/6);
            yL(5,i)=all_eta_L(2,o,i)+(l2+1.7*l1)*sin(-pi/6);
        end
            XL1=[xL(1,1),xL(2,1),xL(3,1),xL(4,1),xL(5,1),xL(1,1)];
            YL1=[yL(1,1),yL(2,1),yL(3,1),yL(4,1),yL(5,1),yL(1,1)];        
            plot(XL1,YL1,'Color','#D95319'),axis equal  
            fill(XL1,YL1,[0,114,189]/255);
            XL2=[xL(1,2),xL(2,2),xL(3,2),xL(4,2),xL(5,2),xL(1,2)];
            YL2=[yL(1,2),yL(2,2),yL(3,2),yL(4,2),yL(5,2),yL(1,2)];        
            plot(XL2,YL2,'Color','#00FFFF'),axis equal  
            fill(XL2,YL2,[0,255,255]/255);
            XL3=[xL(1,3),xL(2,3),xL(3,3),xL(4,3),xL(5,3),xL(1,3)];
            YL3=[yL(1,3),yL(2,3),yL(3,3),yL(4,3),yL(5,3),yL(1,3)];        
            plot(XL3,YL3,'Color','#9400D3'),axis equal  
            fill(XL3,YL3,[148,0,211]/255);
       for i=1:4
          	xF(1,i)=all_eta_F(1,o,i)+l1*sin(-pi/6)+l2*cos(-pi/6);
            xF(2,i)=all_eta_F(1,o,i)+l1*sin(-pi/6)-l2*cos(-pi/6);
            xF(3,i)=all_eta_F(1,o,i)-l1*sin(-pi/6)-l2*cos(-pi/6);
            xF(4,i)=all_eta_F(1,o,i)-l1*sin(-pi/6)+l2*cos(-pi/6);
            xF(5,i)=all_eta_F(1,o,i)+(l2+1.7*l1)*cos(-pi/6);

            yF(1,i)=all_eta_F(2,o,i)-l1*cos(-pi/6)+l2*sin(-pi/6);
            yF(2,i)=all_eta_F(2,o,i)-l1*cos(-pi/6)-l2*sin(-pi/6);
            yF(3,i)=all_eta_F(2,o,i)+l1*cos(-pi/6)-l2*sin(-pi/6);
            yF(4,i)=all_eta_F(2,o,i)+l1*cos(-pi/6)+l2*sin(-pi/6);
            yF(5,i)=all_eta_F(2,o,i)+(l2+1.7*l1)*sin(-pi/6);
       end
            XF1=[xF(1,1),xF(2,1),xF(3,1),xF(4,1),xF(5,1),xF(1,1)];
            YF1=[yF(1,1),yF(2,1),yF(3,1),yF(4,1),yF(5,1),yF(1,1)];        
            plot(XF1,YF1,'Color','#D95319'),axis equal  
            fill(XF1,YF1,[0.85, 0.32, 0.098]);
            XF2=[xF(1,2),xF(2,2),xF(3,2),xF(4,2),xF(5,2),xF(1,2)];
            YF2=[yF(1,2),yF(2,2),yF(3,2),yF(4,2),yF(5,2),yF(1,2)];        
            plot(XF2,YF2,'Color', '#00C78C'),axis equal  
            fill(XF2,YF2,[0,199,140]/255);
            XF3=[xF(1,3),xF(2,3),xF(3,3),xF(4,3),xF(5,3),xF(1,3)];
            YF3=[yF(1,3),yF(2,3),yF(3,3),yF(4,3),yF(5,3),yF(1,3)];        
            plot(XF3,YF3,'Color', '#DDA0DD'),axis equal  
            fill(XF3,YF3,[221,160,221]/255);
            XF4=[xF(1,4),xF(2,4),xF(3,4),xF(4,4),xF(5,4),xF(1,4)];
            YF4=[yF(1,4),yF(2,4),yF(3,4),yF(4,4),yF(5,4),yF(1,4)];        
            plot(XF4,YF4,'Color', '#DAA520'),axis equal  
            fill(XF4,YF4,[218,165,32]/255);
%% 第伍个队形
o=34000;
        new_eta_1 = [  all_eta_L(1,o,1),all_eta_L(2,o,1);
                       all_eta_L(1,o,2),all_eta_L(2,o,2);
                       all_eta_L(1,o,3),all_eta_L(2,o,3);
                       all_eta_F(1,o,1),all_eta_F(2,o,1);
                       all_eta_F(1,o,2),all_eta_F(2,o,2);
                       all_eta_F(1,o,3),all_eta_F(2,o,3);
                       all_eta_F(1,o,4),all_eta_F(2,o,4)];   
       for i=1:m
           plot(new_eta_1(edge(:,i),1),new_eta_1(edge(:,i),2),'Color','K','linewidth',0.8); hold on;
       end
        for i=1:3
          	xL(1,i)=all_eta_L(1,o,i)+l1*sin(0)+l2*cos(0);
            xL(2,i)=all_eta_L(1,o,i)+l1*sin(0)-l2*cos(0);
            xL(3,i)=all_eta_L(1,o,i)-l1*sin(0)-l2*cos(0);
            xL(4,i)=all_eta_L(1,o,i)-l1*sin(0)+l2*cos(0);
            xL(5,i)=all_eta_L(1,o,i)+(l2+1.7*l1)*cos(0);

            yL(1,i)=all_eta_L(2,o,i)-l1*cos(0)+l2*sin(0);
            yL(2,i)=all_eta_L(2,o,i)-l1*cos(0)-l2*sin(0);
            yL(3,i)=all_eta_L(2,o,i)+l1*cos(0)-l2*sin(0);
            yL(4,i)=all_eta_L(2,o,i)+l1*cos(0)+l2*sin(0);
            yL(5,i)=all_eta_L(2,o,i)+(l2+1.7*l1)*sin(0);
        end
            XL1=[xL(1,1),xL(2,1),xL(3,1),xL(4,1),xL(5,1),xL(1,1)];
            YL1=[yL(1,1),yL(2,1),yL(3,1),yL(4,1),yL(5,1),yL(1,1)];        
            plot(XL1,YL1,'Color','#D95319'),axis equal  
            fill(XL1,YL1,[0,114,189]/255);
            XL2=[xL(1,2),xL(2,2),xL(3,2),xL(4,2),xL(5,2),xL(1,2)];
            YL2=[yL(1,2),yL(2,2),yL(3,2),yL(4,2),yL(5,2),yL(1,2)];        
            plot(XL2,YL2,'Color','#00FFFF'),axis equal  
            fill(XL2,YL2,[0,255,255]/255);
            XL3=[xL(1,3),xL(2,3),xL(3,3),xL(4,3),xL(5,3),xL(1,3)];
            YL3=[yL(1,3),yL(2,3),yL(3,3),yL(4,3),yL(5,3),yL(1,3)];        
            plot(XL3,YL3,'Color','#9400D3'),axis equal  
            fill(XL3,YL3,[148,0,211]/255);
       for i=1:4
          	xF(1,i)=all_eta_F(1,o,i)+l1*sin(0)+l2*cos(0);
            xF(2,i)=all_eta_F(1,o,i)+l1*sin(0)-l2*cos(0);
            xF(3,i)=all_eta_F(1,o,i)-l1*sin(0)-l2*cos(0);
            xF(4,i)=all_eta_F(1,o,i)-l1*sin(-0)+l2*cos(0);
            xF(5,i)=all_eta_F(1,o,i)+(l2+1.7*l1)*cos(0);

            yF(1,i)=all_eta_F(2,o,i)-l1*cos(0)+l2*sin(0);
            yF(2,i)=all_eta_F(2,o,i)-l1*cos(0)-l2*sin(0);
            yF(3,i)=all_eta_F(2,o,i)+l1*cos(0)-l2*sin(0);
            yF(4,i)=all_eta_F(2,o,i)+l1*cos(0)+l2*sin(0);
            yF(5,i)=all_eta_F(2,o,i)+(l2+1.7*l1)*sin(0);
       end
            XF1=[xF(1,1),xF(2,1),xF(3,1),xF(4,1),xF(5,1),xF(1,1)];
            YF1=[yF(1,1),yF(2,1),yF(3,1),yF(4,1),yF(5,1),yF(1,1)];        
            plot(XF1,YF1,'Color','#D95319'),axis equal  
            fill(XF1,YF1,[0.85, 0.32, 0.098]);
            XF2=[xF(1,2),xF(2,2),xF(3,2),xF(4,2),xF(5,2),xF(1,2)];
            YF2=[yF(1,2),yF(2,2),yF(3,2),yF(4,2),yF(5,2),yF(1,2)];        
            plot(XF2,YF2,'Color', '#00C78C'),axis equal  
            fill(XF2,YF2,[0,199,140]/255);
            XF3=[xF(1,3),xF(2,3),xF(3,3),xF(4,3),xF(5,3),xF(1,3)];
            YF3=[yF(1,3),yF(2,3),yF(3,3),yF(4,3),yF(5,3),yF(1,3)];        
            plot(XF3,YF3,'Color', '#DDA0DD'),axis equal  
            fill(XF3,YF3,[221,160,221]/255);
            XF4=[xF(1,4),xF(2,4),xF(3,4),xF(4,4),xF(5,4),xF(1,4)];
            YF4=[yF(1,4),yF(2,4),yF(3,4),yF(4,4),yF(5,4),yF(1,4)];        
            plot(XF4,YF4,'Color', '#DAA520'),axis equal  
            fill(XF4,YF4,[218,165,32]/255);            
%% 第六个队形
o=39000;
        new_eta_1 = [  all_eta_L(1,o,1),all_eta_L(2,o,1);
                       all_eta_L(1,o,2),all_eta_L(2,o,2);
                       all_eta_L(1,o,3),all_eta_L(2,o,3);
                       all_eta_F(1,o,1),all_eta_F(2,o,1);
                       all_eta_F(1,o,2),all_eta_F(2,o,2);
                       all_eta_F(1,o,3),all_eta_F(2,o,3);
                       all_eta_F(1,o,4),all_eta_F(2,o,4)];   
       for i=1:m
           plot(new_eta_1(edge(:,i),1),new_eta_1(edge(:,i),2),'Color','K','linewidth',1); hold on;
       end
        for i=1:3
          	xL(1,i)=all_eta_L(1,o,i)+l1*sin(0)+l2*cos(0);
            xL(2,i)=all_eta_L(1,o,i)+l1*sin(0)-l2*cos(0);
            xL(3,i)=all_eta_L(1,o,i)-l1*sin(0)-l2*cos(0);
            xL(4,i)=all_eta_L(1,o,i)-l1*sin(0)+l2*cos(0);
            xL(5,i)=all_eta_L(1,o,i)+(l2+1.7*l1)*cos(0);

            yL(1,i)=all_eta_L(2,o,i)-l1*cos(0)+l2*sin(0);
            yL(2,i)=all_eta_L(2,o,i)-l1*cos(0)-l2*sin(0);
            yL(3,i)=all_eta_L(2,o,i)+l1*cos(0)-l2*sin(0);
            yL(4,i)=all_eta_L(2,o,i)+l1*cos(0)+l2*sin(0);
            yL(5,i)=all_eta_L(2,o,i)+(l2+1.7*l1)*sin(0);
        end
            XL1=[xL(1,1),xL(2,1),xL(3,1),xL(4,1),xL(5,1),xL(1,1)];
            YL1=[yL(1,1),yL(2,1),yL(3,1),yL(4,1),yL(5,1),yL(1,1)];        
            plot(XL1,YL1,'Color','#D95319'),axis equal  
            fill(XL1,YL1,[0,114,189]/255);
            XL2=[xL(1,2),xL(2,2),xL(3,2),xL(4,2),xL(5,2),xL(1,2)];
            YL2=[yL(1,2),yL(2,2),yL(3,2),yL(4,2),yL(5,2),yL(1,2)];        
            plot(XL2,YL2,'Color','#00FFFF'),axis equal  
            fill(XL2,YL2,[0,255,255]/255);
            XL3=[xL(1,3),xL(2,3),xL(3,3),xL(4,3),xL(5,3),xL(1,3)];
            YL3=[yL(1,3),yL(2,3),yL(3,3),yL(4,3),yL(5,3),yL(1,3)];        
            plot(XL3,YL3,'Color','#9400D3'),axis equal  
            fill(XL3,YL3,[148,0,211]/255);
       for i=1:4
          	xF(1,i)=all_eta_F(1,o,i)+l1*sin(0)+l2*cos(0);
            xF(2,i)=all_eta_F(1,o,i)+l1*sin(0)-l2*cos(0);
            xF(3,i)=all_eta_F(1,o,i)-l1*sin(0)-l2*cos(0);
            xF(4,i)=all_eta_F(1,o,i)-l1*sin(0)+l2*cos(0);
            xF(5,i)=all_eta_F(1,o,i)+(l2+1.7*l1)*cos(0);

            yF(1,i)=all_eta_F(2,o,i)-l1*cos(0)+l2*sin(0);
            yF(2,i)=all_eta_F(2,o,i)-l1*cos(0)-l2*sin(0);
            yF(3,i)=all_eta_F(2,o,i)+l1*cos(0)-l2*sin(0);
            yF(4,i)=all_eta_F(2,o,i)+l1*cos(0)+l2*sin(0);
            yF(5,i)=all_eta_F(2,o,i)+(l2+1.7*l1)*sin(0);
       end
            XF1=[xF(1,1),xF(2,1),xF(3,1),xF(4,1),xF(5,1),xF(1,1)];
            YF1=[yF(1,1),yF(2,1),yF(3,1),yF(4,1),yF(5,1),yF(1,1)];        
            plot(XF1,YF1,'Color','#D95319'),axis equal  
            fill(XF1,YF1,[0.85, 0.32, 0.098]);
            XF2=[xF(1,2),xF(2,2),xF(3,2),xF(4,2),xF(5,2),xF(1,2)];
            YF2=[yF(1,2),yF(2,2),yF(3,2),yF(4,2),yF(5,2),yF(1,2)];        
            plot(XF2,YF2,'Color', '#00C78C'),axis equal  
            fill(XF2,YF2,[0,199,140]/255);
            XF3=[xF(1,3),xF(2,3),xF(3,3),xF(4,3),xF(5,3),xF(1,3)];
            YF3=[yF(1,3),yF(2,3),yF(3,3),yF(4,3),yF(5,3),yF(1,3)];        
            plot(XF3,YF3,'Color', '#DDA0DD'),axis equal  
            fill(XF3,YF3,[221,160,221]/255);
            XF4=[xF(1,4),xF(2,4),xF(3,4),xF(4,4),xF(5,4),xF(1,4)];
            YF4=[yF(1,4),yF(2,4),yF(3,4),yF(4,4),yF(5,4),yF(1,4)];        
            plot(XF4,YF4,'Color', '#DAA520'),axis equal  
            fill(XF4,YF4,[218,165,32]/255);    
       
%% velocity （领导者-12）
        figure(5)%速度
        subplot(321)
        plot(all_t(:,:,1),all_nu_L(1,:,1),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$u_1[m/s]$$','Interpreter','latex');
        axis([0,360,-3,3]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-3:3:3]);
        hold on;
        subplot(323)
        plot(all_t(:,:,1),all_nu_L(2,:,1),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$v_1[m/s]$$','Interpreter','latex');
        axis([0,360,-1,1]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-1:1:1]);
        hold on;
        subplot(325)
        plot(all_t(:,:,1),all_nu_L(3,:,1),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$r_1[rad/s]$$','Interpreter','latex');
        axis([0,360,-1,1]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-1:1:1]);
        hold on;
        subplot(322)
        plot(all_t(:,:,1),all_nu_L(1,:,2),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$u_2[m/s]$$','Interpreter','latex');
        axis([0,360,-3,3]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-3:3:3]);
        hold on;
        subplot(324)
        plot(all_t(:,:,1),all_nu_L(2,:,2),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$v_2[m/s]$$','Interpreter','latex');
        axis([0,360,-1,1]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-1:1:1]);
        hold on;
        subplot(326)
        plot(all_t(:,:,1),all_nu_L(3,:,2),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$r_2[rad/s]$$','Interpreter','latex');
        axis([0,360,-1,1]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-1:1:1]);
        hold on;
%% 领导者3
figure(6)%速度
        subplot(321)
        plot(all_t(:,:,1),all_nu_L(1,:,3),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$u_3[m/s]$$','Interpreter','latex');
        axis([0,360,-3,3]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-3:3:3]);
        hold on;
        subplot(323)
        plot(all_t(:,:,1),all_nu_L(2,:,3),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$v_3[m/s]$$','Interpreter','latex');
        axis([0,360,-1,1]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-1:1:1]);
        hold on;
        subplot(325)
        plot(all_t(:,:,1),all_nu_L(3,:,3),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$r_3[rad/s]$$','Interpreter','latex');
        axis([0,360,-1,1]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-1:1:1]);
        hold on;
        

%% velocity（跟随者-45）
        figure(7)%速度     
        subplot(321)
        plot(all_t(:,:,1),all_nu_F(1,:,1),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$u_4[m/s]$$','Interpreter','latex');
        axis([0,360,-3,3]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-3:3:3]);
        hold on;
        subplot(323)
        plot(all_t(:,:,1),all_nu_F(2,:,1),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$v_4[m/s]$$','Interpreter','latex');
        axis([0,360,-1,1]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-1:1:1]);
        hold on;
        subplot(325)
        plot(all_t(:,:,1),all_nu_F(3,:,1),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$r_4[rad/s]$$','Interpreter','latex');
        axis([0,360,-1,1]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-1:1:1]);
        hold on;
        subplot(322)
        plot(all_t(:,:,1),all_nu_F(1,:,2),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$u_5[m/s]$$','Interpreter','latex');
        axis([0,360,-3,3]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-3:3:3]);
        hold on;
        subplot(324)
        plot(all_t(:,:,1),all_nu_F(2,:,2),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$v_5[m/s]$$','Interpreter','latex');
        axis([0,360,-1,1]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-1:1:1]);
        hold on;
        subplot(326)
        plot(all_t(:,:,1),all_nu_F(3,:,2),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$r_5[rad/s]$$','Interpreter','latex');
        axis([0,360,-1,1]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-1:1:1]);
        hold on;
        
%% velocity （跟随者6-7）
        figure(8)%速度 
        subplot(321)
        plot(all_t(:,:,1),all_nu_F(1,:,3),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$u_6[m/s]$$','Interpreter','latex');
        axis([0,360,-3,3]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-3:3:3]);
        hold on;
        subplot(323)
        plot(all_t(:,:,1),all_nu_F(2,:,3),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$v_6[m/s]$$','Interpreter','latex');
        axis([0,360,-1,1]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-1:1:1]);
        hold on;
        subplot(325)
        plot(all_t(:,:,1),all_nu_F(3,:,3),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$r_6[rad/s]$$','Interpreter','latex');
        axis([0,360,-1,1]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-1:1:1]);
        hold on;       
        subplot(322)
        plot(all_t(:,:,1),all_nu_F(1,:,4),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$u_7[m/s]$$','Interpreter','latex');
        axis([0,360,-3,3]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-3:3:3]);
        hold on;
        subplot(324)
        plot(all_t(:,:,1),all_nu_F(2,:,4),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$v_7[m/s]$$','Interpreter','latex');
        axis([0,360,-1,1]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-1:1:1]);
        hold on;
        subplot(326)
        plot(all_t(:,:,1),all_nu_F(3,:,4),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$r_7[rad/s]$$','Interpreter','latex');
        axis([0,360,-1,1]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-1:1:1]);
        hold on;       
%% tau （领导者-123）
        figure(91)%力矩
        subplot(321)
        plot(all_t(:,:,1),all_tau_L(1,:,1),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N]$$','Interpreter','latex');
        axis([0,360,-30,60]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-30:30:60]);
        w=legend('$$ \tau_{u,1} $$');
        set(w,'Interpreter','latex','Orientation','horizon')
        hold on;
        subplot(323)
        plot(all_t(:,:,1),all_tau_L(1,:,2),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N]$$','Interpreter','latex');
        axis([0,360,-30,60]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-30:30:60]);
        w=legend('$$ \tau_{u,2} $$');
        set(w,'Interpreter','latex','Orientation','horizon')
        hold on;
        subplot(325)
        plot(all_t(:,:,1),all_tau_L(1,:,3),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N]$$','Interpreter','latex');
        axis([0,360,-30,60]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-30:30:60]);
        w=legend('$$ \tau_{u,3} $$');
        set(w,'Interpreter','latex','Orientation','horizon')
        hold on;
        subplot(322)
        plot(all_t(:,:,1),all_tau_L(3,:,1),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N.m]$$','Interpreter','latex');
        axis([0,360,-8,8]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-8:8:8]);
        w=legend('$$ \tau_{r,1} $$');
        set(w,'Interpreter','latex','Orientation','horizon')
        hold on;
        subplot(324)
        plot(all_t(:,:,1),all_tau_L(3,:,2),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N.m]$$','Interpreter','latex');
        axis([0,360,-8,8]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-8:8:8]);
        w=legend('$$ \tau_{r,2} $$');
        set(w,'Interpreter','latex','Orientation','horizon')
        hold on;
        subplot(326)
        plot(all_t(:,:,1),all_tau_L(3,:,3),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N.m]$$','Interpreter','latex');
        axis([0,360,-8,8]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-8:8:8]);
        w=legend('$$ \tau_{r,3} $$');
        set(w,'Interpreter','latex','Orientation','horizon')
        hold on;
%% tau(跟随者456)
        figure(101)%力矩
        subplot(321)
        plot(all_t(:,:,1),all_tau_F(1,:,1),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N]$$','Interpreter','latex');
        axis([0,360,-30,30]); 
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-30:30:30]);
        w=legend('$$ \tau_{u,4} $$');
        set(w,'Interpreter','latex','Orientation','horizon')
        hold on;
        subplot(322)
        plot(all_t(:,:,1),all_tau_F(3,:,1),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N.m]$$','Interpreter','latex');
        axis([0,360,-5,5]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-5:5:5]);
        w=legend('$$ \tau_{r,4} $$');
        set(w,'Interpreter','latex','Orientation','horizon')
        hold on;
        subplot(323)
        plot(all_t(:,:,1),all_tau_F(1,:,2),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N]$$','Interpreter','latex');
        axis([0,360,-30,30]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-30:30:30]);
        w=legend('$$ \tau_{u,5} $$');
        set(w,'Interpreter','latex','Orientation','horizon')
        hold on;
        subplot(324)
        plot(all_t(:,:,1),all_tau_F(3,:,2),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N.m]$$','Interpreter','latex');
        axis([0,360,-5,5]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-5:5:5]);
        w=legend('$$ \tau_{r,5} $$');
        set(w,'Interpreter','latex','Orientation','horizon')
        hold on;       
        subplot(325)
        plot(all_t(:,:,1),all_tau_F(1,:,3),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N]$$','Interpreter','latex');
        axis([0,360,-30,30]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-30:30:30]);
        w=legend('$$ \tau_{u,6} $$');
        set(w,'Interpreter','latex','Orientation','horizon')
        hold on;
        subplot(326)
        plot(all_t(:,:,1),all_tau_F(3,:,3),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N.m]$$','Interpreter','latex');
        axis([0,360,-5,5]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-5:5:5]);
        w=legend('$$ \tau_{r,6} $$');
        set(w,'Interpreter','latex','Orientation','horizon')
        hold on;        
%% tau(跟随者7)
        figure(11)%力矩
        subplot(321)
        plot(all_t(:,:,1),all_tau_F(1,:,4),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N]$$','Interpreter','latex');
        axis([0,360,-30,30]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-30:30:30]);
        w=legend('$$ \tau_{u,7} $$');
        set(w,'Interpreter','latex','Orientation','horizon')
        hold on;
        subplot(322)
        plot(all_t(:,:,1),all_tau_F(3,:,4),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N.m]$$','Interpreter','latex');
        axis([0,360,-5,5]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-5:5:5]);
        w=legend('$$ \tau_{r,7} $$');
        set(w,'Interpreter','latex','Orientation','horizon')
        hold on;
%% 跟踪误差（领航者123）
        figure(12)
        %跟踪误差(第一个和第三个跟随者)
        subplot(321)
        plot(all_t(:,:,1),e_eta_L(1,:,1),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$ [m] $$','Interpreter','latex');
        axis([0,360,-12,12]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-12:12:12]);
        w=legend('$$\Vert p_1 - p_1^* \Vert $$');
        set(w,'Interpreter','latex','Orientation','horizon')
        hold on;
        subplot(322)
        plot(all_t(:,:,1),e_eta_L(1,:,2),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$ m $$','Interpreter','latex');
        axis([0,360,-12,12]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-12:12:12]);
        w=legend('$$\Vert p_2  -p_2^* \Vert $$');
        set(w,'Interpreter','latex','Orientation','horizon')
        hold on
        %跟踪估计（第二个跟随者）
        subplot(323)
        plot(all_t(:,:,1),e_eta_L(1,:,3),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$ m $$','Interpreter','latex');
        axis([0,360,-12,12]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-12:12:12]);
        w=legend('$$\Vert p_3 - p_3^* \Vert $$');
        set(w,'Interpreter','latex','Orientation','horizon')
        hold on;
%% 跟踪误差 （跟随者4567）
        figure(13)
        %跟踪误差(第一个和第二个跟随者)
        subplot(321)
        plot(all_t(:,:,1),e_eta_F(1,:,1),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$ m $$','Interpreter','latex');
        axis([0,360,-15,30]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-15:15:30]);
        w=legend('$$\Vert p_4 - p_4^* \Vert $$');
        set(w,'Interpreter','latex','Orientation','horizon')
        hold on;
        subplot(322)
        plot(all_t(:,:,1),e_eta_F(1,:,2),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$ m $$','Interpreter','latex');
        axis([0,360,-15,30]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-15:15:30]);
        w=legend('$$\Vert p_5 - p_5^* \Vert $$');
        set(w,'Interpreter','latex','Orientation','horizon')
        hold on
        %跟踪估计（第三个和第四个跟随者）
        subplot(323)
        plot(all_t(:,:,1),e_eta_F(1,:,3),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$ m $$','Interpreter','latex');
        axis([0,360,-15,30]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-15:15:30]);
        w=legend('$$\Vert p_6 - p_6^* \Vert $$');
        set(w,'Interpreter','latex','Orientation','horizon')
        hold on;
        subplot(324)
        plot(all_t(:,:,1),e_eta_F(1,:,4),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$ m $$','Interpreter','latex');
        axis([0,360,-15,30]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-15:15:30]);
        w=legend('$$\Vert p_7 - p_7^* \Vert $$');
        set(w,'Interpreter','latex','Orientation','horizon')
        hold on
      
       %% heso(领导者12)
        figure(14)%hESO
        subplot(321)
        plot(all_t(:,:,1),all_sigma_L(1,:,1),'b','linewidth',1.5); hold on
        plot(all_t(:,:,1),all_Msigma_hat(1,:,1),'r--','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N]$$','Interpreter','latex');
        axis([0,360,-12,12]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-12:12:12]);
        w=legend('$$\sigma_{u,1}$$','ESO');
        set(w,'Interpreter','latex','Orientation','horizon')
        w.ItemTokenSize = [15,15];
        hold on;
        subplot(323)
        plot(all_t(:,:,1),all_sigma_L(2,:,1),'b','linewidth',1.5); hold on
        plot(all_t(:,:,1),all_Msigma_hat(2,:,1),'r--','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N]$$','Interpreter','latex');
        axis([0,360,-12,12]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-12:12:12]);
        w=legend('$$\sigma_{v,1}$$','ESO');
        set(w,'Interpreter','latex','Orientation','horizon')
        w.ItemTokenSize = [15,15];hold on
        subplot(325)
        plot(all_t(:,:,1),all_sigma_L(3,:,1),'b','linewidth',1.5); hold on
        plot(all_t(:,:,1),all_Msigma_hat(3,:,1),'r--','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N.m]$$','Interpreter','latex');
        axis([0,360,-6,6]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-6:6:6]);
        w=legend('$$\sigma_{r,1}$$','ESO');
        set(w,'Interpreter','latex','Orientation','horizon')
        w.ItemTokenSize = [15,15];hold on
        subplot(322)
        plot(all_t(:,:,1),all_sigma_L(1,:,2),'b','linewidth',1.5); hold on
        plot(all_t(:,:,1),all_Msigma_hat(1,:,2),'r--','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N]$$','Interpreter','latex');
        axis([0,360,-12,12]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-12:12:12]);
        w=legend('$$\sigma_{u,2}$$','ESO');
        set(w,'Interpreter','latex','Orientation','horizon')
        w.ItemTokenSize = [15,15];
        hold on;
        subplot(324)
        plot(all_t(:,:,1),all_sigma_L(2,:,2),'b','linewidth',1.5); hold on
        plot(all_t(:,:,1),all_Msigma_hat(2,:,2),'r--','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N]$$','Interpreter','latex');
        axis([0,360,-12,12]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-12:12:12]);
        w=legend('$$\sigma_{v,2}$$','ESO');
        set(w,'Interpreter','latex','Orientation','horizon')
        w.ItemTokenSize = [15,15];hold on
        subplot(326)
        plot(all_t(:,:,1),all_sigma_L(3,:,2),'b','linewidth',1.5); hold on
        plot(all_t(:,:,1),all_Msigma_hat(3,:,2),'r--','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N.m]$$','Interpreter','latex');
        axis([0,360,-6,6]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-6:6:6]);
        w=legend('$$\sigma_{r,2}$$','ESO');
        set(w,'Interpreter','latex','Orientation','horizon')
        w.ItemTokenSize = [15,15];hold on
%% heso(领导者3)
        figure(15)%hESO
        subplot(321)
        plot(all_t(:,:,1),all_sigma_L(1,:,3),'b','linewidth',1.5); hold on
        plot(all_t(:,:,1),all_Msigma_hat(1,:,3),'r--','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N]$$','Interpreter','latex');
        axis([0,360,-12,12]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-12:12:12]);
        w=legend('$$\sigma_{u,3}$$','ESO');
        set(w,'Interpreter','latex','Orientation','horizon')
        w.ItemTokenSize = [15,15];
        hold on;
        subplot(322)
        plot(all_t(:,:,1),all_sigma_L(2,:,3),'b','linewidth',1.5); hold on
        plot(all_t(:,:,1),all_Msigma_hat(2,:,3),'r--','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N]$$','Interpreter','latex');
        axis([0,360,-12,12]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-12:12:12]);
        w=legend('$$\sigma_{v,3}$$','ESO');
        set(w,'Interpreter','latex','Orientation','horizon')
        w.ItemTokenSize = [15,15];hold on
        subplot(323)
        plot(all_t(:,:,1),all_sigma_L(3,:,3),'b','linewidth',1.5); hold on
        plot(all_t(:,:,1),all_Msigma_hat(3,:,3),'r--','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N.m]$$','Interpreter','latex');
        axis([0,360,-6,6]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-6:6:6]);
        w=legend('$$\sigma_{r,3}$$','ESO');
        set(w,'Interpreter','latex','Orientation','horizon')
        w.ItemTokenSize = [15,15];hold on
       %% heso(跟随者45)
        figure(16)%hESO
        subplot(321)
        plot(all_t(:,:,1),all_sigma_F(1,:,1),'b','linewidth',1.5); hold on
        plot(all_t(:,:,1),all_sigma_hat_F(1,:,1),'r--','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N]$$','Interpreter','latex');
        axis([0,360,-12,12]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-12:12:12]);
        w=legend('$$\sigma_{u,4}$$','ESO');
        set(w,'Interpreter','latex','Orientation','horizon')
        w.ItemTokenSize = [15,15];
        hold on;
        subplot(323)
        plot(all_t(:,:,1),all_sigma_F(2,:,1),'b','linewidth',1.5); hold on
        plot(all_t(:,:,1),all_sigma_hat_F(2,:,1),'r--','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N]$$','Interpreter','latex');
        axis([0,360,-12,12]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-12:12:12]);
        w=legend('$$\sigma_{v,4}$$','ESO');
        set(w,'Interpreter','latex','Orientation','horizon')
        w.ItemTokenSize = [15,15];hold on
        subplot(325)
        plot(all_t(:,:,1),all_sigma_F(3,:,1),'b','linewidth',1.5); hold on
        plot(all_t(:,:,1),all_sigma_hat_F(3,:,1),'r--','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N.m]$$','Interpreter','latex');
        axis([0,360,-6,6]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-6:6:6]);
        w=legend('$$\sigma_{r,4}$$','ESO');
        set(w,'Interpreter','latex','Orientation','horizon')
        w.ItemTokenSize = [15,15];hold on
        subplot(322)
        plot(all_t(:,:,1),all_sigma_F(1,:,2),'b','linewidth',1.5); hold on
        plot(all_t(:,:,1),all_sigma_hat_F(1,:,2),'r--','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N]$$','Interpreter','latex');
        axis([0,360,-12,12]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-12:12:12]);
        w=legend('$$\sigma_{u,5}$$','ESO');
        set(w,'Interpreter','latex','Orientation','horizon')
        w.ItemTokenSize = [15,15];
        hold on;
        subplot(324)
        plot(all_t(:,:,1),all_sigma_F(2,:,2),'b','linewidth',1.5); hold on
        plot(all_t(:,:,1),all_sigma_hat_F(2,:,2),'r--','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N]$$','Interpreter','latex');
        axis([0,360,-12,12]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-12:12:12]);
        w=legend('$$\sigma_{v,5}$$','ESO');
        set(w,'Interpreter','latex','Orientation','horizon')
        w.ItemTokenSize = [15,15];hold on
        subplot(326)
        plot(all_t(:,:,1),all_sigma_F(3,:,2),'b','linewidth',1.5); hold on
        plot(all_t(:,:,1),all_sigma_hat_F(3,:,2),'r--','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N.m]$$','Interpreter','latex');
        axis([0,360,-6,6]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-6:6:6]);
        w=legend('$$\sigma_{r,5}$$','ESO');
        set(w,'Interpreter','latex','Orientation','horizon')
        w.ItemTokenSize = [15,15];hold on
       %% heso(跟随者67)
        figure(17)%hESO
        subplot(321)
        plot(all_t(:,:,1),all_sigma_F(1,:,3),'b','linewidth',1.5); hold on
        plot(all_t(:,:,1),all_sigma_hat_F(1,:,3),'r--','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N]$$','Interpreter','latex');
        axis([0,360,-12,12]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-12:12:12]);
        w=legend('$$\sigma_{u,6}$$','ESO');
        set(w,'Interpreter','latex','Orientation','horizon')
        w.ItemTokenSize = [15,15];
        hold on;
        subplot(323)
        plot(all_t(:,:,1),all_sigma_F(2,:,3),'b','linewidth',1.5); hold on
        plot(all_t(:,:,1),all_sigma_hat_F(2,:,3),'r--','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N]$$','Interpreter','latex');
        axis([0,360,-12,12]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-12:12:12]);
        w=legend('$$\sigma_{v,6}$$','ESO');
        set(w,'Interpreter','latex','Orientation','horizon')
        w.ItemTokenSize = [15,15];hold on
        subplot(325)
        plot(all_t(:,:,1),all_sigma_F(3,:,3),'b','linewidth',1.5); hold on
        plot(all_t(:,:,1),all_sigma_hat_F(3,:,3),'r--','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N.m]$$','Interpreter','latex');
        axis([0,360,-6,6]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-6:6:6]);
        w=legend('$$\sigma_{r,6}$$','ESO');
        set(w,'Interpreter','latex','Orientation','horizon')
        w.ItemTokenSize = [15,15];hold on
        subplot(322)
        plot(all_t(:,:,1),all_sigma_F(1,:,4),'b','linewidth',1.5); hold on
        plot(all_t(:,:,1),all_sigma_hat_F(1,:,4),'r--','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N]$$','Interpreter','latex');
        axis([0,360,-12,12]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-12:12:12]);
        w=legend('$$\sigma_{u,7}$$','ESO');
        set(w,'Interpreter','latex','Orientation','horizon')
        w.ItemTokenSize = [15,15];
        hold on;
        subplot(324)
        plot(all_t(:,:,1),all_sigma_F(2,:,4),'b','linewidth',1.5); hold on
        plot(all_t(:,:,1),all_sigma_hat_F(2,:,4),'r--','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N]$$','Interpreter','latex');
        axis([0,360,-12,12]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-12:12:12]);
        w=legend('$$\sigma_{v,7}$$','ESO');
        set(w,'Interpreter','latex','Orientation','horizon')
        w.ItemTokenSize = [15,15];hold on
        subplot(326)
        plot(all_t(:,:,1),all_sigma_F(3,:,4),'b','linewidth',1.5); hold on
        plot(all_t(:,:,1),all_sigma_hat_F(3,:,4),'r--','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N.m]$$','Interpreter','latex');
        axis([0,360,-6,6]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-6:6:6]);
        w=legend('$$\sigma_{r,7}$$','ESO');
        set(w,'Interpreter','latex','Orientation','horizon')
        w.ItemTokenSize = [15,15];hold on  
        %% 估计误差
         %heso(领导者12)
        figure(181)%hESO
        subplot(321)
        plot(all_t(:,:,1),all_sigma_L(1,:,1)-all_Msigma_hat(1,:,1),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N]$$','Interpreter','latex');
        axis([0,360,-12,12]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-12:12:12]);
        w=legend('$$\tilde{\sigma}_{u,1}$$');
        set(w,'Interpreter','latex','Orientation','horizon')
        w.ItemTokenSize = [15,15];
        hold on;
        subplot(323)
        plot(all_t(:,:,1),all_sigma_L(2,:,1)-all_Msigma_hat(2,:,1),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N]$$','Interpreter','latex');
        axis([0,360,-12,12]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-12:12:12]);
        w=legend('$$\tilde{\sigma}_{v,1}$$');
        set(w,'Interpreter','latex','Orientation','horizon')
        w.ItemTokenSize = [15,15];hold on
        subplot(325)
        plot(all_t(:,:,1),all_sigma_L(3,:,1)-all_Msigma_hat(3,:,1),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N.m]$$','Interpreter','latex');
        axis([0,360,-6,6]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-6:6:6]);
        w=legend('$$\tilde{\sigma}_{r,1}$$');
        set(w,'Interpreter','latex','Orientation','horizon')
        w.ItemTokenSize = [15,15];hold on
        subplot(322)
        plot(all_t(:,:,1),all_sigma_L(1,:,2)-all_Msigma_hat(1,:,2),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N]$$','Interpreter','latex');
        axis([0,360,-12,12]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-12:12:12]);
        w=legend('$$\tilde{\sigma}_{u,2}$$');
        set(w,'Interpreter','latex','Orientation','horizon')
        w.ItemTokenSize = [15,15];
        hold on;
        subplot(324)
        plot(all_t(:,:,1),all_sigma_L(2,:,2)-all_Msigma_hat(2,:,2),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N]$$','Interpreter','latex');
        axis([0,360,-12,12]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-12:12:12]);
        w=legend('$$\tilde{\sigma}_{v,2}$$');
        set(w,'Interpreter','latex','Orientation','horizon')
        w.ItemTokenSize = [15,15];hold on
        subplot(326)
        plot(all_t(:,:,1),all_sigma_L(3,:,2)-all_Msigma_hat(3,:,2),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N.m]$$','Interpreter','latex');
        axis([0,360,-6,6]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-6:6:6]);
        w=legend('$$\tilde{\sigma}_{r,2}$$');
        set(w,'Interpreter','latex','Orientation','horizon')
        w.ItemTokenSize = [15,15];hold on
%% heso(领导者3)
        figure(19)%hESO
        subplot(321)
        plot(all_t(:,:,1),all_sigma_L(1,:,3)-all_Msigma_hat(1,:,3),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N]$$','Interpreter','latex');
        axis([0,360,-12,12]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-12:12:12]);
        w=legend('$$\tilde{\sigma}_{u,3}$$');
        set(w,'Interpreter','latex','Orientation','horizon')
        w.ItemTokenSize = [15,15];
        hold on;
        subplot(322)
        plot(all_t(:,:,1),all_sigma_L(2,:,3)-all_Msigma_hat(2,:,3),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N]$$','Interpreter','latex');
        axis([0,360,-12,12]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-12:12:12]);
        w=legend('$$\tilde{\sigma}_{v,3}$$');
        set(w,'Interpreter','latex','Orientation','horizon')
        w.ItemTokenSize = [15,15];hold on
        subplot(323)
        plot(all_t(:,:,1),all_sigma_L(3,:,3)-all_Msigma_hat(3,:,3),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N.m]$$','Interpreter','latex');
        axis([0,360,-6,6]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-6:6:6]);
        w=legend('$$\tilde{\sigma}_{r,3}$$');
        set(w,'Interpreter','latex','Orientation','horizon')
        w.ItemTokenSize = [15,15];hold on
       %% heso(跟随者45)
        figure(20)%hESO
        subplot(321)
        plot(all_t(:,:,1),all_sigma_F(1,:,1)-all_sigma_hat_F(1,:,1),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N]$$','Interpreter','latex');
        axis([0,360,-12,12]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-12:12:12]);
        w=legend('$$\tilde{\sigma}_{u,4}$$');
        set(w,'Interpreter','latex','Orientation','horizon')
        w.ItemTokenSize = [15,15];
        hold on;
        subplot(323)
        plot(all_t(:,:,1),all_sigma_F(2,:,1)-all_sigma_hat_F(2,:,1),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N]$$','Interpreter','latex');
        axis([0,360,-12,12]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-12:12:12]);
        w=legend('$$\tilde{\sigma}_{v,4}$$');
        set(w,'Interpreter','latex','Orientation','horizon')
        w.ItemTokenSize = [15,15];hold on
        subplot(325)
        plot(all_t(:,:,1),all_sigma_F(3,:,1)-all_sigma_hat_F(3,:,1),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N.m]$$','Interpreter','latex');
        axis([0,360,-6,6]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-6:6:6]);
        w=legend('$$\tilde{\sigma}_{r,4}$$');
        set(w,'Interpreter','latex','Orientation','horizon')
        w.ItemTokenSize = [15,15];hold on
        subplot(322)
        plot(all_t(:,:,1),all_sigma_F(1,:,2)-all_sigma_hat_F(1,:,2),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N]$$','Interpreter','latex');
        axis([0,360,-12,12]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-12:12:12]);
        w=legend('$$\tilde{\sigma}_{u,5}$$');
        set(w,'Interpreter','latex','Orientation','horizon')
        w.ItemTokenSize = [15,15];
        hold on;
        subplot(324)
        plot(all_t(:,:,1),all_sigma_F(2,:,2)-all_sigma_hat_F(2,:,2),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N]$$','Interpreter','latex');
        axis([0,360,-12,12]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-12:12:12]);
        w=legend('$$\tilde{\sigma}_{v,5}$$');
        set(w,'Interpreter','latex','Orientation','horizon')
        w.ItemTokenSize = [15,15];hold on
        subplot(326)
        plot(all_t(:,:,1),all_sigma_F(3,:,2)-all_sigma_hat_F(3,:,2),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N.m]$$','Interpreter','latex');
        axis([0,360,-6,6]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-6:6:6]);
        w=legend('$$\tilde{\sigma}_{r,5}$$');
        set(w,'Interpreter','latex','Orientation','horizon')
        w.ItemTokenSize = [15,15];hold on
       %% heso(跟随者67)
        figure(21)%hESO
        subplot(321)
        plot(all_t(:,:,1),all_sigma_F(1,:,3)-all_sigma_hat_F(1,:,3),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N]$$','Interpreter','latex');
        axis([0,360,-12,12]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-12:12:12]);
        w=legend('$$\tilde{\sigma}_{u,6}$$');
        set(w,'Interpreter','latex','Orientation','horizon')
        w.ItemTokenSize = [15,15];
        hold on;
        subplot(323)
        plot(all_t(:,:,1),all_sigma_F(2,:,3)-all_sigma_hat_F(2,:,3),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N]$$','Interpreter','latex');
        axis([0,360,-12,12]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-12:12:12]);
        w=legend('$$\tilde{\sigma}_{v,6}$$');
        set(w,'Interpreter','latex','Orientation','horizon')
        w.ItemTokenSize = [15,15];hold on
        subplot(325)
        plot(all_t(:,:,1),all_sigma_F(3,:,3)-all_sigma_hat_F(3,:,3),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N.m]$$','Interpreter','latex');
        axis([0,360,-6,6]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-6:6:6]);
        w=legend('$$\tilde{\sigma}_{r,6}$$');
        set(w,'Interpreter','latex','Orientation','horizon')
        w.ItemTokenSize = [15,15];hold on
        subplot(322)
        plot(all_t(:,:,1),all_sigma_F(1,:,4)-all_sigma_hat_F(1,:,4),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N]$$','Interpreter','latex');
        axis([0,360,-12,12]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-12:12:12]);
        w=legend('$$\tilde{\sigma}_{u,7}$$');
        set(w,'Interpreter','latex','Orientation','horizon')
        w.ItemTokenSize = [15,15];
        hold on;
        subplot(324)
        plot(all_t(:,:,1),all_sigma_F(2,:,4)-all_sigma_hat_F(2,:,4),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N]$$','Interpreter','latex');
        axis([0,360,-12,12]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-12:12:12]);
        w=legend('$$\tilde{\sigma}_{v,7}$$');
        set(w,'Interpreter','latex','Orientation','horizon')
        w.ItemTokenSize = [15,15];hold on
        subplot(326)
        plot(all_t(:,:,1),all_sigma_F(3,:,4)-all_sigma_hat_F(3,:,4),'b','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N.m]$$','Interpreter','latex');
        axis([0,360,-6,6]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-6:6:6]);
        w=legend('$$\tilde{\sigma}_{r,7}$$');
        set(w,'Interpreter','latex','Orientation','horizon')
        w.ItemTokenSize = [15,15];hold on
        
%% duibi
        %heso(领导者12)
        figure(231111)%hESO
        subplot(321)
        plot(all_t(:,:,1),all_sigma_L(1,:,1)-all_Msigma_hat(1,:,1),'r','linewidth',1.5); hold on
        plot(all_t(:,:,1),all_sigma_L(1,:,1)-all_Msigma_hat_c(1,:,1),'b--','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N]$$','Interpreter','latex');
        axis([0,360,-12,12]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-12:12:12]);
%         w=legend('$$\tilde{\sigma}_{u,1}$$','$$\tilde{\sigma}_{u,1}$$');
%         set(w,'Interpreter','latex')
%         w.ItemTokenSize = [15,15];
        hold on;
        subplot(323)
        plot(all_t(:,:,1),all_sigma_L(2,:,1)-all_Msigma_hat(2,:,1),'r','linewidth',1.5); hold on
        plot(all_t(:,:,1),all_sigma_L(2,:,1)-all_Msigma_hat_c(2,:,1),'b--','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N]$$','Interpreter','latex');
        axis([0,360,-12,12]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-12:12:12]);
%         w=legend('$$\tilde{\sigma}_{v,1}$$','$$\tilde{\sigma}_{v,1}$$');
%         set(w,'Interpreter','latex')
%         w.ItemTokenSize = [15,15];hold on
        subplot(325)
        plot(all_t(:,:,1),all_sigma_L(2,:,2)/2-all_Msigma_hat(2,:,2)/2,'r','linewidth',1.5); hold on
        plot(all_t(:,:,1),all_sigma_L(2,:,2)/2-all_Msigma_hat_c(2,:,2)/2,'b--','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N.m]$$','Interpreter','latex');
        axis([0,360,-6,6]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-6:6:6]);
%         w=legend('$$\tilde{\sigma}_{r,1}$$','$$\tilde{\sigma}_{r,1}$$');
%         set(w,'Interpreter','latex')
%         w.ItemTokenSize = [15,15];hold on
        subplot(322)
        plot(all_t(:,:,1),all_sigma_L(1,:,2)-all_Msigma_hat(1,:,2),'r','linewidth',1.5); hold on
        plot(all_t(:,:,1),all_sigma_L(1,:,2)-all_Msigma_hat_c(1,:,2),'b--','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N]$$','Interpreter','latex');
        axis([0,360,-12,12]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-12:12:12]);
%         w=legend('$$\tilde{\sigma}_{u,2}$$','$$\tilde{\sigma}_{u,2}$$');
%         set(w,'Interpreter','latex')
%         w.ItemTokenSize = [15,15];
        hold on;
        subplot(324)
        plot(all_t(:,:,1),all_sigma_L(2,:,2)-all_Msigma_hat(2,:,2),'r','linewidth',1.5); hold on
        plot(all_t(:,:,1),all_sigma_L(2,:,2)-all_Msigma_hat_c(2,:,2),'b--','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N]$$','Interpreter','latex');
        axis([0,360,-12,12]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-12:12:12]);
%         w=legend('$$\tilde{\sigma}_{v,2}$$','$$\tilde{\sigma}_{v,2}$$');
%         set(w,'Interpreter','latex')
%         w.ItemTokenSize = [15,15];hold on
        subplot(326)
        plot(all_t(:,:,1),all_sigma_L(2,:,2)/2-all_Msigma_hat(2,:,2)/2,'r','linewidth',1.5); hold on
        plot(all_t(:,:,1),all_sigma_L(2,:,2)/2-all_Msigma_hat_c(2,:,2)/2,'b--','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N.m]$$','Interpreter','latex');
        axis([0,360,-6,6]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-6:6:6]);
%         w=legend('$$\tilde{\sigma}_{r,2}$$','$$\tilde{\sigma}_{r,2}$$');
%         set(w,'Interpreter','latex')
%         w.ItemTokenSize = [15,15];hold on
 
figure(24)%hESO
        subplot(321)
        plot(all_t(:,:,1),all_sigma_L(1,:,1)-all_Msigma_hat(1,:,1),'r','linewidth',1.5); hold on
        plot(all_t(:,:,1),all_sigma_L(1,:,1)-all_Msigma_hat_c(1,:,1),'b--','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N]$$','Interpreter','latex');
        axis([0,360,-12,12]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-12:12:12]);
        w=legend('$$\tilde{\sigma}_{u,1}$$','$$\tilde{\sigma}_{u,1}$$');
        set(w,'Interpreter','latex')
        w.ItemTokenSize = [15,15];
        hold on;
        subplot(323)
        plot(all_t(:,:,1),all_sigma_L(2,:,1)-all_Msigma_hat(2,:,1),'r','linewidth',1.5); hold on
        plot(all_t(:,:,1),all_sigma_L(2,:,1)-all_Msigma_hat_c(2,:,1),'b--','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N]$$','Interpreter','latex');
        axis([0,360,-12,12]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-12:12:12]);
        w=legend('$$\tilde{\sigma}_{v,1}$$','$$\tilde{\sigma}_{v,1}$$');
        set(w,'Interpreter','latex')
        w.ItemTokenSize = [15,15];hold on
        subplot(325)
        plot(all_t(:,:,1),all_sigma_L(2,:,2)/2-all_Msigma_hat(2,:,2)/2,'r','linewidth',1.5); hold on
        plot(all_t(:,:,1),all_sigma_L(2,:,2)/2-all_Msigma_hat_c(2,:,2)/2,'b--','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N.m]$$','Interpreter','latex');
        axis([0,360,-6,6]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-6:6:6]);
        w=legend('$$\tilde{\sigma}_{r,1}$$','$$\tilde{\sigma}_{r,1}$$');
        set(w,'Interpreter','latex')
        w.ItemTokenSize = [15,15];hold on
        subplot(322)
        plot(all_t(:,:,1),all_sigma_L(1,:,2)-all_Msigma_hat(1,:,2),'r','linewidth',1.5); hold on
        plot(all_t(:,:,1),all_sigma_L(1,:,2)-all_Msigma_hat_c(1,:,2),'b--','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N]$$','Interpreter','latex');
        axis([0,360,-12,12]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-12:12:12]);
        w=legend('$$\tilde{\sigma}_{u,2}$$','$$\tilde{\sigma}_{u,2}$$');
        set(w,'Interpreter','latex')
        w.ItemTokenSize = [15,15];
        hold on;
        subplot(324)
        plot(all_t(:,:,1),all_sigma_L(2,:,2)-all_Msigma_hat(2,:,2),'r','linewidth',1.5); hold on
        plot(all_t(:,:,1),all_sigma_L(2,:,2)-all_Msigma_hat_c(2,:,2),'b--','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N]$$','Interpreter','latex');
        axis([0,360,-12,12]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-12:12:12]);
        w=legend('$$\tilde{\sigma}_{v,2}$$','$$\tilde{\sigma}_{v,2}$$');
        set(w,'Interpreter','latex')
        w.ItemTokenSize = [15,15];hold on
        subplot(326)
        plot(all_t(:,:,1),all_sigma_L(2,:,2)/2-all_Msigma_hat(2,:,2)/2,'r','linewidth',1.5); hold on
        plot(all_t(:,:,1),all_sigma_L(2,:,2)/2-all_Msigma_hat_c(2,:,2)/2,'b--','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N.m]$$','Interpreter','latex');
        axis([0,360,-6,6]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-6:6:6]);
        w=legend('$$\tilde{\sigma}_{r,2}$$','$$\tilde{\sigma}_{r,2}$$');
        set(w,'Interpreter','latex')
        w.ItemTokenSize = [15,15];hold on
%% heso(跟随者45)
        figure(251)%hESO
        subplot(321)
        plot(all_t(:,:,1),all_sigma_L(2,:,2)-all_Msigma_hat(2,:,2),'r','linewidth',1.5); hold on
        plot(all_t(:,:,1),all_sigma_L(2,:,2)-all_Msigma_hat_c(2,:,2),'b--','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N]$$','Interpreter','latex');
        axis([0,360,-12,12]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-12:12:12]);
        w=legend('$$\tilde{\sigma}_{u,4}$$','$$\tilde{\sigma}_{u,4}$$');
        set(w,'Interpreter','latex')
        w.ItemTokenSize = [15,15];
        hold on;
        subplot(323)
        plot(all_t(:,:,1),all_sigma_L(2,:,2)-all_Msigma_hat(2,:,2),'r','linewidth',1.5); hold on
        plot(all_t(:,:,1),all_sigma_L(2,:,2)-all_Msigma_hat_c(2,:,2),'b--','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N]$$','Interpreter','latex');
        axis([0,360,-12,12]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-12:12:12]);
        w=legend('$$\tilde{\sigma}_{v,4}$$','$$\tilde{\sigma}_{v,4}$$');
        set(w,'Interpreter','latex')
        w.ItemTokenSize = [15,15];hold on
        subplot(325)
        plot(all_t(:,:,1),all_sigma_L(2,:,2)/2-all_Msigma_hat(2,:,2)/2,'r','linewidth',1.5); hold on
        plot(all_t(:,:,1),all_sigma_L(2,:,2)/2-all_Msigma_hat_c(2,:,2)/2,'b--','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N.m]$$','Interpreter','latex');
        axis([0,360,-6,6]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-6:6:6]);
        w=legend('$$\tilde{\sigma}_{r,4}$$','$$\tilde{\sigma}_{r,4}$$');
        set(w,'Interpreter','latex')
        w.ItemTokenSize = [15,15];hold on
        subplot(322)
        plot(all_t(:,:,1),all_sigma_L(2,:,2)-all_Msigma_hat(2,:,2),'r','linewidth',1.5); hold on
        plot(all_t(:,:,1),all_sigma_L(2,:,2)-all_Msigma_hat_c(2,:,2),'b--','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N]$$','Interpreter','latex');
        axis([0,360,-12,12]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-12:12:12]);
        w=legend('$$\tilde{\sigma}_{u,5}$$','$$\tilde{\sigma}_{u,5}$$');
        set(w,'Interpreter','latex')
        w.ItemTokenSize = [15,15];
        hold on;
        subplot(324)
        plot(all_t(:,:,1),all_sigma_L(2,:,2)-all_Msigma_hat(2,:,2),'r','linewidth',1.5); hold on
        plot(all_t(:,:,1),all_sigma_L(2,:,2)-all_Msigma_hat_c(2,:,2),'b--','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N]$$','Interpreter','latex');
        axis([0,360,-12,12]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-12:12:12]);
        w=legend('$$\tilde{\sigma}_{v,5}$$','$$\tilde{\sigma}_{v,5}$$');
        set(w,'Interpreter','latex')
        w.ItemTokenSize = [15,15];hold on
        subplot(326)
        plot(all_t(:,:,1),all_sigma_L(2,:,2)/2-all_Msigma_hat(2,:,2)/2,'r','linewidth',1.5); hold on
        plot(all_t(:,:,1),all_sigma_L(2,:,2)/2-all_Msigma_hat_c(2,:,2)/2,'b--','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N.m]$$','Interpreter','latex');
        axis([0,360,-6,6]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-6:6:6]);
        w=legend('$$\tilde{\sigma}_{r,5}$$','$$\tilde{\sigma}_{r,5}$$');
        set(w,'Interpreter','latex')
        w.ItemTokenSize = [15,15];hold on        
%% 
        figure(26)%hESO
        subplot(321)
        plot(all_t(:,:,1),all_sigma_L(2,:,2)-all_Msigma_hat(2,:,2),'r','linewidth',1.5); hold on
        plot(all_t(:,:,1),all_sigma_L(2,:,2)-all_Msigma_hat_c(2,:,2),'b--','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N]$$','Interpreter','latex');
        axis([0,360,-12,12]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-12:12:12]);
%         w=legend('$$\tilde{\sigma}_{u,4}$$','$$\tilde{\sigma}_{u,4}$$');
%         set(w,'Interpreter','latex')
%         w.ItemTokenSize = [15,15];
        hold on;
        subplot(323)
        plot(all_t(:,:,1),all_sigma_L(2,:,2)-all_Msigma_hat(2,:,2),'r','linewidth',1.5); hold on
        plot(all_t(:,:,1),all_sigma_L(2,:,2)-all_Msigma_hat_c(2,:,2),'b--','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N]$$','Interpreter','latex');
        axis([0,360,-12,12]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-12:12:12]);
%         w=legend('$$\tilde{\sigma}_{v,4}$$','$$\tilde{\sigma}_{v,4}$$');
%         set(w,'Interpreter','latex')
%         w.ItemTokenSize = [15,15];hold on
        subplot(325)
        plot(all_t(:,:,1),all_sigma_L(2,:,2)/2-all_Msigma_hat(2,:,2)/2,'r','linewidth',1.5); hold on
        plot(all_t(:,:,1),all_sigma_L(2,:,2)/2-all_Msigma_hat_c(2,:,2)/2,'b--','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N.m]$$','Interpreter','latex');
        axis([0,360,-6,6]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-6:6:6]);
%         w=legend('$$\tilde{\sigma}_{r,4}$$','$$\tilde{\sigma}_{r,4}$$');
%         set(w,'Interpreter','latex')
%         w.ItemTokenSize = [15,15];hold on
        subplot(322)
        plot(all_t(:,:,1),all_sigma_L(2,:,2)-all_Msigma_hat(2,:,2),'r','linewidth',1.5); hold on
        plot(all_t(:,:,1),all_sigma_L(2,:,2)-all_Msigma_hat_c(2,:,2),'b--','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N]$$','Interpreter','latex');
        axis([0,360,-12,12]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-12:12:12]);
%         w=legend('$$\tilde{\sigma}_{u,5}$$','$$\tilde{\sigma}_{u,5}$$');
%         set(w,'Interpreter','latex')
%         w.ItemTokenSize = [15,15];
        hold on;
        subplot(324)
        plot(all_t(:,:,1),all_sigma_L(2,:,2)-all_Msigma_hat(2,:,2),'r','linewidth',1.5); hold on
        plot(all_t(:,:,1),all_sigma_L(2,:,2)-all_Msigma_hat_c(2,:,2),'b--','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N]$$','Interpreter','latex');
        axis([0,360,-12,12]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-12:12:12]);
%         w=legend('$$\tilde{\sigma}_{v,5}$$','$$\tilde{\sigma}_{v,5}$$');
%         set(w,'Interpreter','latex')
%         w.ItemTokenSize = [15,15];hold on
        subplot(326)
        plot(all_t(:,:,1),all_sigma_L(2,:,2)/2-all_Msigma_hat(2,:,2)/2,'r','linewidth',1.5); hold on
        plot(all_t(:,:,1),all_sigma_L(2,:,2)/2-all_Msigma_hat_c(2,:,2)/2,'b--','linewidth',1.5); hold on
        xlabel('$$t[s]$$','Interpreter','latex');ylabel('$$[N.m]$$','Interpreter','latex');
        axis([0,360,-6,6]);
        set(gca,'Xtick',[0:120:360]);
        set(gca,'Ytick',[-6:6:6]);
%         w=legend('$$\tilde{\sigma}_{r,5}$$','$$\tilde{\sigma}_{r,5}$$');
%         set(w,'Interpreter','latex')
%         w.ItemTokenSize = [15,15];hold on          