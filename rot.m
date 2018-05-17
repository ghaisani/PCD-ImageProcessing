function [imagerot] = rot(image,degree)

switch mod(degree, 360)
    % Special cases
    case 0
        imagerot = image;
    case 90
        imagerot = rot90(image);
    case 180
        imagerot = image(end:-1:1, end:-1:1);
    case 270
        imagerot = rot90(image(end:-1:1, end:-1:1));

    % General rotations
    otherwise

        % Convert to radians and create transformation matrix
        a = degree*pi/180;
        R = [+cos(a) +sin(a); -sin(a) +cos(a)];

        % Figure out the size of the transformed image
        [m,n,p] = size(image);
        dest = round( [1 1; 1 n; m 1; m n]*R );
        dest = bsxfun(@minus, dest, min(dest)) + 1;
        imagerot = zeros([max(dest) p],class(image));

        % Map all pixels of the transformed image to the original image
        for ii = 1:size(imagerot,1)
            for jj = 1:size(imagerot,2)
                source = ([ii jj]-dest(1,:))*R.';
                if all(source >= 1) && all(source <= [m n])

                    % Get all 4 surrounding pixels
                    C = ceil(source);
                    F = floor(source);

                    % Compute the relative areas
                    A = [...
                        ((C(2)-source(2))*(C(1)-source(1))),...
                        ((source(2)-F(2))*(source(1)-F(1)));
                        ((C(2)-source(2))*(source(1)-F(1))),...
                        ((source(2)-F(2))*(C(1)-source(1)))];

                    % Extract colors and re-scale them relative to area
                    cols = bsxfun(@times, A, double(image(F(1):C(1),F(2):C(2),:)));

                    % Assign                     
                    imagerot(ii,jj,:) = sum(sum(cols),2);

                end
            end
        end        
end



% rotMat = [cos((pi.*ang/180)) sin((pi.*ang/180)); -sin((pi.*ang/180)) cos((pi.*ang/180))];
%centerW = round(size(A,1)/2);
%centerH = round(size(A,2)/2);
%h=255.* uint8(ones(size(A)));
%for x = 1:size(A,1)
%    for y = 1:size(A,2)
%        point =[x-centerW;y-centerH] ;
%        product = rotMat * point;
%        product = int16(product);
%        newx =product(1,1);
%        newy=product(2,1);
%            if newx+centerW<=size(A,1)&& newx+centerW > 0 && newy+centerH<=size(A,2)&& newy+centerH > 0 
%                h(newx+centerW,newy+centerH) = A(x,y);
%            end
%    end
%end