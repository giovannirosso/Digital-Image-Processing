%segundo
%script para testar as distancias e 
%valores a serem usados.

global first_square_x;
global first_square_y;

%position of first square 
first_square_x = 0.089048; %187/dx
first_square_y = 0.097980; %291/dy

global dx;
global dy;
[dy dx] = size(im1); %length of paper may vary
%some helpful values
distance_x = (x12-x11)/dx; %distance between x's top percent on page size
distance_y = (y21-y11)/dy; %distance between y's left percent on page size

%im1 = imresize(im1, [dy*(0.90762/distance_x) dx*(0.92593/distance_y)]);
im1 = imresize(im1, [dy*(0.90762/distance_y) dx*(0.92593/distance_x)]);
[dy dx] = size(im1); %length of paper may vary

%distance x is 0.90762 and 
%distance y is 0.92593 on test page
%apply scale on image if it is different


square_x_len = 0.024762; %(249-187)/dx         
square_y_len = 0.020875; %(353-291)/dy        

distance_x_squares = 0.078571; %(352-187)/dx 
distance_y_squares = 0.034007; %(392-291)/dy

##distance_x_between_squares = 0.045340 %36/dx 
##distance_y_between_squares = 0.070410 %79/dy

distance_x_first_square = 0.015715 %(-x11+first_square_x*dx)/dx
distance_y_first_square = 0.036701 %(first_square_y*dy-y11)/dy 

first_square_x = x11-distance_x_first_square*dx
first_square_y = y11+distance_y_first_square*dy

