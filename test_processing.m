classdef test_processing < matlab.unittest.TestCase
    properties
        proc
        collector
        Set
    end

    methods(TestClassSetup)
        function class_setup(testCase)
            addpath('subprocesses');
        end
    end

    methods(TestMethodSetup)
        function setup(testCase)
            testCase.collector = parameter_collector();
            testCase.proc = processor();
        end

        function setupSetMock(testCase)
            testCase.Set.num_drops = 3;
            drop1.Value.accx = [1,2,3,4];
            drop2.Value.accx = [1,2,500,-501];
            drop3.Value.accx = [-100,2,3];
            drop1.Value.accy = [1,2,3,4];
            drop2.Value.accy = [1,2,500,-501];
            drop3.Value.accy = [-100,2,3];
            drop1.Value.accz = [1,2,3,4];
            drop2.Value.accz = [1,2,500,-501];
            drop3.Value.accz = [-100,2,3];
            testCase.Set.drops = [drop1, drop2, drop3];
        end
    end

    methods(TestMethodTeardown)
    end

    methods(Test)
        function testApplyProcess(testCase)
            function basicProcess(collector, dropSet)
                field_name = 'test';
                value = 12341;
                collector.add_data(value, field_name);
            end
            testCase.proc.apply_process(testCase.collector,...
                                        testCase.Set, @basicProcess);
            testCase.assertEqual(value,...
                                 testCase.collector.calculated.test);
        end

        function test_max_accx(testCase)
            testCase.proc.apply_process(testCase.collector,...
                                        testCase.Set, @max_accx);
            testCase.assertEqual(testCase.collector.calculated.max_accx, [4;501;100]);
        end

        function test_max_accy(testCase)
            testCase.proc.apply_process(testCase.collector,...
                                        testCase.Set, @max_accy);
            testCase.assertEqual(testCase.collector.calculated.max_accy, [4;501;100]);
        end

        function test_max_accz(testCase)
            testCase.proc.apply_process(testCase.collector,...
                                        testCase.Set, @max_accz);
            testCase.assertEqual(testCase.collector.calculated.max_accz, [4;501;100]);
        end
    end
end
