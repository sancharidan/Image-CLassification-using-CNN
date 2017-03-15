function [ mat_out ] = Vectorise_cell( cell_in )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
t=size(cell_in);
s=t(2);
for i=1:s
    mat_out(i)=cell_in{i};
end
end

