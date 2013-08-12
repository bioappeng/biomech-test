classdef unit_processing < matlab.unittest.TestCase
    properties
        proc
        collector
        Set
    end

    methods(TestClassSetup)
        function class_setup(testCase)
            addpath('../resources/');
            addpath('../../../lib/resources/');
            addpath('../../../lib/framework/');
            addpath('../../../lib/framework/subprocesses');
            testCase.proc = processor();
        end
    end

    methods(TestMethodSetup)
        function setup(testCase)
            testCase.collector = calculation_collector();
        end

        function setupMocks(testCase)
        end
    end

    methods(TestMethodTeardown)
        function teardown(testCase)
        end
    end

    methods(Test)
       % function test_apply_process(testCase)
       %     a_basic_process = process_basic_process();
       %     testCase.proc.apply_process(testCase.collector,...
       %                                 testCase.Set, a_basic_process);
       %     testCase.assertEqual(a_basic_process.value,...
       %                          testCase.collector.calculated.test);
       % end
        
        %function test_process_max_accx(testCase)
        %    drop1.Value.accx = signal('', [1,2,3,4]);
        %    drop2.Value.accx = signal('', [1,2,500,-501]);
        %    drop3.Value.accx = signal('', [-100,2,3]);
        %    testCase.Set.drops = [drop1, drop2, drop3];
        %    process = process_max_accx();
        %    testCase.proc.apply_process(testCase.collector,...
        %                                testCase.Set, process);
        %    testCase.assertEqual(testCase.collector.calculated.max_accx, [4;501;100]);
        %end

        %function test_process_max_accy(testCase)
        %    drop1.Value.accy = signal('', [1,2,3,4]);
        %    drop2.Value.accy = signal('', [1,2,500,-501]);
        %    drop3.Value.accy = signal('', [-100,2,3]);
        %    process = process_max_accy();
        %    testCase.Set.drops = [drop1, drop2, drop3];
        %    testCase.proc.apply_process(testCase.collector,...
        %                                testCase.Set, process);
        %    testCase.assertEqual(testCase.collector.calculated.max_accy, [4;501;100]);
        %end

        %function test_process_max_accz(testCase)
        %    drop1.Value.accz = signal('', [1,2,3,4]);
        %    drop2.Value.accz = signal('', [1,2,500,-501]);
        %    drop3.Value.accz = signal('', [-100,2,3]);
        %    testCase.Set.drops = [drop1, drop2, drop3];
        %    process = process_max_accz();
        %    testCase.proc.apply_process(testCase.collector,...
        %                                testCase.Set, process);
        %    testCase.assertEqual(testCase.collector.calculated.max_accz, [4;501;100]);
        %end
    end
end
