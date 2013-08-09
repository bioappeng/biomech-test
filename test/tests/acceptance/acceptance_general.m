classdef acceptance_general < matlab.unittest.TestCase
    methods(TestClassSetup)
        function class_setup_other(testCase)
            addpath('../../../lib/framework/');
            addpath('../../../lib/framework/subprocesses/');
            addpath('resources/');
        end
    end

    methods(TestMethodSetup)
        function setup_Sets(testCase)
        end
    end

    methods(TestMethodTeardown)
        function teardown(testCase)
        end
    end

    methods(Test)
        function test_drop_set_constructor_ascii(testCase)
            ascii_set = drop_set('resources/small_data/ascii/', 0, true, true);
            testCase.assertInstanceOf(ascii_set, 'drop_set');
            testCase.assertNotEmpty(ascii_set.drops);
            testCase.assertEqual(ascii_set.num_drops, length(ascii_set.drops));
            testCase.assertEqual(ascii_set.three_axis_load, true);
        end

        function test_drop_set_constructor_mat(testCase)
            mat_set = drop_set('resources/small_data/mat/test.mat', 0, true, false);
            testCase.assertInstanceOf(mat_set, 'drop_set');
            testCase.assertNotEmpty(mat_set.drops);
            testCase.assertEqual(mat_set.num_drops, length(mat_set.drops));
            testCase.assertEqual(mat_set.three_axis_load, true);
        end

        function test_drop_constructor_mat(testCase)
            mat_set = drop_set('resources/small_data/mat/test.mat', 0, true, false);
            a_mat_drop = mat_set.drops(3).Value;
            testCase.assertInstanceOf(a_mat_drop, 'mat_drop');
            testCase.assertNotEmpty(a_mat_drop.pot.data);
            testCase.assertNotEmpty(a_mat_drop.accy.data);
        end

        function test_drop_constructor_ascii(testCase)
            ascii_set = drop_set('resources/small_data/ascii/', 0, true, true);
            an_ascii_drop = ascii_set.drops(1).Value;
            testCase.assertEqual(an_ascii_drop.id, 'TT5_14_091555');
            testCase.assertInstanceOf(an_ascii_drop, 'ascii_drop');
            testCase.assertNotEmpty(an_ascii_drop.pot.data);
            testCase.assertNotEmpty(an_ascii_drop.accy.data);
        end

       % function test_apply_process(testCase)
       %     a_basic_process = process_basic_process();
       %     testCase.proc.apply_process(testCase.collector,...
       %                                 testCase.Set, a_basic_process);
       %     testCase.assertEqual(a_basic_process.value,...
       %                          testCase.collector.calculated.test);
       % end
    end
end
