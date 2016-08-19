# comet3n
COMET3N plots trajectories of multiple objects in 3D 

comet3n plots trajectories of multiple objects in 3D with controllable speed and tail length. It takes an M*5 array as an input. Column 1-4 are the (x,y,z,t) coordinate of an object, respectively. Column 5 is object id number. Time and object id number must both be integers. See example below: 

% Object 1 
t = 1 : 500; 
x = sin( t *pi/50); 
y = cos(t * pi/30); 
z = 0.5 * t; 
id = ones(length(t), 1);

obj1 = cat(2, x', y', z', t', id);

% Object 2 
t = 1 : 350; 
x = 2*sin(t * pi/30); 
y = -cos( t * pi/60); 
z = 2 * t; 
id = ones(length(t), 1)*2;

obj2 = cat(2, x', y', z',t', id);

src = cat(1, obj1, obj2); 
comet3n(src);
