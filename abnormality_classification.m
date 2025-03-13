data = readmatrix('ecg.csv');  % Load ECG data
X = data(:, 1:140);  % ECG signal data
y = data(:, 141);    % Labels (0 = Normal, 1 = Abnormal)
X = (X - mean(X, 1)) ./ std(X, 1);  % Normalize each feature

cv = cvpartition(size(X,1), 'HoldOut', 0.2);
X_train = X(training(cv), :);
y_train = y(training(cv), :);
X_test = X(test(cv), :);
y_test = y(test(cv), :);

svmModel = fitcsvm(X_train, y_train, 'KernelFunction', 'linear');

y_pred = predict(svmModel, X_test);
accuracy = sum(y_pred == y_test) / length(y_test) * 100;
disp(['Test Accuracy: ', num2str(accuracy), '%']);
