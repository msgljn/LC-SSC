function Plot_data( data,t,fig_int,str_title)
cols={'g','b'};
%% plot
   cols={'r','b','m','black','m','g','b','y','black','m'};
   shapes={'p','^','o','>','*','p','^','o','>','*'};
   figure(fig_int)
   for i=1:length(unique(t))
       pos=[];
       pos=find(i==t);
       hold on
       plot(data(pos,1),data(pos,2),shapes{i},'color',cols{i},'markersize',7);
   end
    title(str_title);
end

