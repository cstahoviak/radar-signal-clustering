clc;
clear;
close ALL;

tic;

for i=1:10
    struct_array(i).points = i*ones(1,5);
    struct_array(i).t = toc;
end

struct2.points = zeros(1,5);
struct2.t = toc;

struct_array(end+1) = struct2

struct_array2 = [struct_array, struct2]
