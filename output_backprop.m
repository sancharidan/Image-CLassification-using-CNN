function [ delta ] = output_backprop( output, label, fcout, k )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
delta=(label-output);
delta=delta*0.2;
delta=delta.*(1-(tanh(fcout).*tanh(fcout)));
end

