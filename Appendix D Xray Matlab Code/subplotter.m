function subplotter( varargin )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
n=ceil(nargin/3);
figure;
for i=1:nargin
    
    subplot(n,3,i);
    imshow(varargin{i},'InitialMagnification',100);
    
end

end

