function comet3n( src, varargin )
% COMET3N plots trajectories of multiple objects in 3D 
%   comet3n(src) plots tracjectors of objects specified by MxN  matrix src.
%   src has to be at least M * 5 in size.
%   The first 3 columns of src must be the x, y, and z coordinates of the
%   object at a timepoint. The 4th column is timepoint where spatial
%   coordinates are registered. The 5th column is the ID number of the
%   object. 
%
%   Optinally, color can be supplied in the form rgb indexes. src in this
%   case would be an M * 8 matrix.
%
%   comet3n(src) plots cells and trajectories using the color
%   specified by the 6th to 8th column (R,G and B) of the input file, src. 
%   
%   comet3n(src,'speed',num) allows different plotting speed, ranging from
%   1 to 10. When speed argument is not given, this function will plot at
%   maximum speed.
%
%   comet3n(src,'taillength',num) allows user to specify taillength.
%   Defauly is 20.
%
%   comet3n(src,'headsize',num) allows user to change the size of head.
%   The scale is relative to default size, which is 1/100 of the x axis
%   range.
%    
%   comet3n(src, 'tailwidth', num) allows user to change tail width.
% 
%   comet3n(src,'alpha',num) allows user to change alpha value of the comet
%   head. Default is 1. 
%
%   Version 1.3
%   Copyright Chaoyuan Yeh, 2016
%     
ObjList_T = cell(max(src(:,4)),1);
for tt = 1:max(src(:,4))
    ObjList_T{tt} = src(src(:,4)==tt,5);
end

if size(src,2) ~= 8 
    color_temp = hsv(max(src(:,5)));
    color_temp = color_temp(randperm(max(src(:,5)))',:);
    color = zeros(size(src,1),3);
    for ii = 1 : max(src(:,5))
        ind = (src(:,5) == ii);
        color(ind,1) = color_temp(ii,1);
        color(ind,2) = color_temp(ii,2);
        color(ind,3) = color_temp(ii,3);
    end
    src(:,6:8) = color;
    clearvars ind color color_temp;
end

PosList_ID = cell(max(src(:,5)),1);
for ii = 1:max(src(:,5))
    PosList_ID{ii} = src(src(:,5)==ii,[1:4,6:8]);
end

if any(strcmpi(varargin,'taillength'))
    tailLength = varargin{find(strcmpi(varargin,'taillength'))+1};
else
    tailLength = 20;
end

if any(strcmpi(varargin,'tailwidth'))
    tailwidth = varargin{find(strcmpi(varargin,'tailwidth'))+1};
else
    tailwidth = 1;
end

if any(strcmpi(varargin,'speed'))
    if varargin{find(strcmpi(varargin,'speed'))+1} < 1 ... 
        || varargin{find(strcmpi(varargin,'speed'))+1} > 10
        error('Speed can only be between 1 and 10');
    else
        speed = varargin{find(strcmpi(varargin,'speed'))+1};
    end
end

xmin = min(src(:,1));
xmax = max(src(:,1));
ymin = min(src(:,2));
ymax = max(src(:,2));
zmin = min(src(:,3));
zmax = max(src(:,3));
yratio = (ymax-ymin)/(xmax-xmin);
zratio = (zmax-zmin)/(xmax-xmin);
scale =(xmax-xmin)/100;

if any(strcmpi(varargin,'headsize'))
    scale = scale * varargin{find(strcmpi(varargin,'headsize'))+1};
end

if any(strcmpi(varargin,'alpha'))
    alpha = varargin{find(strcmpi(varargin,'alpha'))+1};
else
    alpha = 1;
end

[sx,sy,sz] = sphere(15);
figure;
hold on
axis([xmin xmax ymin ymax zmin zmax])
ax = gca;
ax.Color = 'k';
grid on
ax.GridColor = 'w';
ax.GridAlpha = 0.5;
view([45 45])

for tt = 1:max(src(:,4))
    ObjList = ObjList_T{tt};
    [az, el] = view;
    for ii = 1:length(ObjList)
        ind_t = find(PosList_ID{ObjList(ii)}(:,4)==tt);
        surface(scale*sx+PosList_ID{ObjList(ii)}(ind_t,1),...
            scale*yratio*sy+PosList_ID{ObjList(ii)}(ind_t,2),...
            scale*zratio*sz+PosList_ID{ObjList(ii)}(ind_t,3),...
            'FaceAlpha',alpha,'EdgeColor','none','FaceColor',...
            PosList_ID{ObjList(ii)}(ind_t,5:7));
        
        if ind_t <= tailLength
            plot3(PosList_ID{ObjList(ii)}(1:ind_t,1),...
                PosList_ID{ObjList(ii)}(1:ind_t,2),...
                PosList_ID{ObjList(ii)}(1:ind_t,3),...
                'color',PosList_ID{ObjList(ii)}(ind_t,5:7),...
                'LineWidth', tailwidth);
        else
            plot3(PosList_ID{ObjList(ii)}(ind_t-tailLength:ind_t,1),...
                PosList_ID{ObjList(ii)}(ind_t-tailLength:ind_t,2),...
                PosList_ID{ObjList(ii)}(ind_t-tailLength:ind_t,3),...
                'color',PosList_ID{ObjList(ii)}(ind_t,5:7),...
                'LineWidth', tailwidth);
        end
    end
    view([az el])
    camlight('right')
    drawnow
    if exist('speed','var'), pause(1/(10*speed)); end
    if tt ~= max(src(:,4)), cla; end
end