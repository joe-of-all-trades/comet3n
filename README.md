# comet3n
COMET3N plots trajectories of multiple objects in 3D 

comet3n plots trajectories of multiple objects in 3D with controllable speed and tail length. It takes an M*5 array as an input. Column 1-4 are the (x,y,z,t) coordinate of an object, respectively. Column 5 is object id number. Time and object id number must both be integers. See example below, or just run democomet3n.m 

% Object 1 

t = (1:500)*pi/50;
x = 16*(sin(t).^3);
y = 13*cos(t) - 5*cos(2*t) - 2*cos(3*t) - cos(4*t);
t = 1:500;
z = 0.5 * t;
id = ones(length(t), 1);
obj1 = cat(2, x', y', z', t', id);

% Object 2 

t = (1:500)*pi/50;
x = -16*(sin(t).^3);
y = 13*cos(t) - 5*cos(2*t) - 2*cos(3*t) - cos(4*t);
t = 1:500;
z = -0.5 * t;
id = ones(length(t), 1)*2;
obj2 = cat(2, x', y', z', t', id);

% Combine two objects.

src = cat(1, obj1, obj2);

comet3n(src, 'speed', 5, 'headsize', 1.5, 'tailwidth', 2,...
    'taillength', 100 )
