function [ varargout ] = Linear_interpolator( varargin )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% variable argument list, must be more than one argument
numArg=nargin;
for i=1:(numArg-1)
    [~, c1]=size(varargin{i});
    [~, c2]=size(varargin{i+1});
    if c1<c2
        varargout{i}=(varargin{i}+varargin{i+1}(:,1:c1))/2;
    elseif c1>c2
        varargout{i}=(varargin{i}(:,1:c2)+varargin{i+1})/2;
    else
        varargout{i}=(varargin{i}+varargin{i+1})/2;
    end
    
end 
end

