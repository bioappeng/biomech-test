function results = runtests(which_tests)
    import matlab.unittest.TestSuite;
    import matlab.unittest.TestRunner;

    results = run(TestSuite.fromFolder('test/tests/', 'IncludingSubfolders', true));

    time = 0.0;
    for i=1:length(results)
        time = time + results(i).Duration;
    end
    num_passed = nnz([results.Passed]);
    disp([num2str(num_passed), ' passed & ', num2str(numel(results) - num_passed), ' failed in ', num2str(time), 's'])
    disp(' ')
end
