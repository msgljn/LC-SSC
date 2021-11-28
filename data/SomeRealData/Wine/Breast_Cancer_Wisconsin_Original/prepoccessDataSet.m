
label_x=[];
label_x_t=[];
unlabel_x=[];
unlabel_x_t=[];
draw_n=[];
for i=1:max(unique(class))
    pos=[];
    pos=find(class==i);
    len=size(pos,1);
    if len>15
        draw_n(i)=15;
    else
        draw_n(i)=len;
    end
    label_x=[label_x;data(pos(1:draw_n(i)),:)];
    unlabel_x=[unlabel_x;data(pos(draw_n(i)+1:end),:)];
    label_x_t=[label_x_t;class(pos(1:draw_n(i)),:)];
    unlabel_x_t=[unlabel_x_t;class(pos(draw_n(i)+1:end),:)];
end
save label_x label_x
save label_x_t label_x_t
save unlabel_x unlabel_x
save unlabel_x_t unlabel_x_t