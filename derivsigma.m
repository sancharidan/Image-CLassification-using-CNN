function [ deriv ] = derivsigma( fcout )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
deriv=exp(-fcout)./((1+exp(-fcout)).^2);

end

