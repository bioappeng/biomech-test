function results = runtests(which_tests)
    import matlab.unittest.TestSuite;
    import matlab.unittest.TestRunner;

    runner = TestRunner.withTextOutput;
    switch which_tests
        case 'all',
            results = run(TestSuite.fromFolder('test/tests/', 'IncludingSubfolders', true));
        case 'unit',
            results = run(TestSuite.fromFolder('test/tests/unit/', 'IncludingSubfolders', true));
    end

    time = 0.0;
    for i=1:length(results)
        time = time + results(i).Duration;
    end
    num_passed = nnz([results.Passed]);
    disp([num2str(num_passed), ' passed & ', num2str(numel(results) - num_passed), ' failed in ', num2str(time), 's'])
    disp(' ')
end
