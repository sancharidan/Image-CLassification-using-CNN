function [ relu_out ] = ReLU( relu_in )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
relu_zeroes=zeros(size(relu_in));
relu_out=max(relu_zeroes,relu_in);
end

