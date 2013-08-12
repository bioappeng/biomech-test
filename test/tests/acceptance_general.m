classdef acceptance_general < matlab.unittest.TestCase
    properties
        assembler;
    end
    methods(TestClassSetup)
        function class_setup_other(testCase)
            addpath('../../lib/framework/');
            addpath('../../lib/framework/subprocesses/');
            addpath('resources/');
        end

        function class_setup_objects(testCase)
            testCase.assembler = drop_assembler();
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
        function test_ascii_set_creation(testCase)
            drops = testCase.assembler.assemble('resources/small_data/ascii/', 0, true);
            ascii_set = drop_set(drops);
            testCase.assertInstanceOf(ascii_set, 'drop_set');
            testCase.assertNotEmpty(ascii_set.drops);
            testCase.assertEqual(ascii_set.num_drops, length(ascii_set.drops));
        end

        function test_mat_set_creation(testCase)
            drops = testCase.assembler.assemble('resources/small_data/mat/test.mat', 0, false);
            mat_set = drop_set(drops);
            testCase.assertInstanceOf(mat_set, 'drop_set');
            testCase.assertNotEmpty(mat_set.drops);
            testCase.assertEqual(mat_set.num_drops, length(mat_set.drops));
        end

        function test_drop_assembler_generates_non_empty_list_of_ascii_drops(testCase)
            assembler = drop_assembler();
            drops = assembler.assemble('resources/small_data/ascii/', 0, true);
            testCase.assertNotEmpty(drops);
            for i=1:length(drops)
                testCase.assertInstanceOf(drops(i).Value, 'drop');
            end
        end

        function test_drop_assembler_generates_non_empty_list_of_mat_drops(testCase)
            assembler = drop_assembler();
            drops = assembler.assemble('resources/small_data/mat/test.mat', 0, false);
            testCase.assertNotEmpty(drops);
            for i=1:length(drops)
                testCase.assertInstanceOf(drops(i).Value, 'drop');
            end
        end
    end
end
