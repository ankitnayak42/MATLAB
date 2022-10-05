clear all %#ok<CLALL>
clc
layer_number=1;
road_gap=1;
order=3;
slicing_height=0.6;
retraction_height=1;
FEED=1000;
RPM=60;
maintxt=fopen('hilbert.txt','wt');
GMline='X%3.4f Y%3.4f\n';

 for h=1:layer_number
%                     path_pts=path_pts_cell{x};
% [x,y] = peano_curve(order,road_gap);
[x,y]=hilbert_new(order,road_gap);
 path_z(1:length(x))=h*slicing_height;
 path_pts=[x,y,path_z'];

                    [r,c]=size(path_pts);
                    for i=1:r
                        if i==1
                            fprintf(maintxt,'G00 X%3.4f Y%3.4f\n',path_pts(i,1:2));
%                             fprintf(maintxt,'G00 Z%3.4f\n',path_pts(1,3)+Sliceheight-Sliceheight/2);
                            fprintf(maintxt,'G00 Z%3.4f\n',path_pts(1,3));
                            fprintf(maintxt,'G01 F%3.0f\n',FEED);
                            fprintf(maintxt,'M04 S%2.0f\n',RPM);
                        elseif i==r                  

                            fprintf(maintxt,'M05\n');
%                             fprintf(maintxt,'G00 Z80\n\n\n');
                            fprintf(maintxt,'G00 Z%3.4f\n\n\n',(path_pts(1,3)+retraction_height));
                        else
                            fprintf(maintxt,GMline,path_pts(i,1:2));
                        end
                    end
                    hold on
                   comet3(x,y,path_z)
                     plot3(x,y,path_z)
                      axis ('tight') 
                      view (3)
                    x=[];
                    y=[];
                    path_pts=[];
                    
 end
fprintf(maintxt,'M30\n');