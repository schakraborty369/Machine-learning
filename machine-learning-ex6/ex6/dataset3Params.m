function [C, sigma] = dataset3Params(X, y, Xval, yval)
%EX6PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = EX6PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;
load('ex6data3.mat');

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%

A = [0.01 0.03 0.1 0.3 1 3 10 30];
B = [0 0 0];

for j = 1:8

 for i = 1:8

    C = A(1,j);
    sigma = A(1,i);
    model= svmTrain(X, y, C, @(x1, x2) gaussianKernel(x1, x2, sigma)); 
    predictions = svmPredict(model, Xval);
    predict_error = mean(double(predictions ~= yval));
    B = [B ; [C sigma predict_error]];
 
 end;

end;

B = B((2:end),:);
[val,ind] = min(B,[],1);
C = B(ind(:,3),1);
sigma = B(ind(:,3),2);

% =========================================================================

end
