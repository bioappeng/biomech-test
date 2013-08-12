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
        function test_drop_set_constructor_ascii(testCase)
            drops = testCase.assembler.assemble('resources/small_data/ascii/', 0, true);
            ascii_set = drop_set(drops);
            testCase.assertInstanceOf(ascii_set, 'drop_set');
            testCase.assertNotEmpty(ascii_set.drops);
            testCase.assertEqual(ascii_set.num_drops, length(ascii_set.drops));
        end

        function test_drop_set_constructor_mat(testCase)
            drops = testCase.assembler.assemble('resources/small_data/mat/test.mat', 0, false);
            mat_set = drop_set(drops);
            testCase.assertInstanceOf(mat_set, 'drop_set');
            testCase.assertNotEmpty(mat_set.drops);
            testCase.assertEqual(mat_set.num_drops, length(mat_set.drops));
        end

%        function test_drop_constructor_mat(testCase)
%            mat_set = drop_set(testCase.assembler.assemble('resources/small_data/mat/test.mat', 0, true, false));
%            a_mat_drop = mat_set.drops(3).Value;
%            testCase.assertInstanceOf(a_mat_drop, 'mat_drop');
%            testCase.assertNotEmpty(a_mat_drop.pot.data);
%            testCase.assertNotEmpty(a_mat_drop.accy.data);
%        end
%
%        function test_drop_constructor_ascii(testCase)
%            ascii_set = drop_set(testCase.assembler.assemble('resources/small_data/ascii/', 0, true, true));
%            an_ascii_drop = ascii_set.drops(1).Value;
%            testCase.assertEqual(an_ascii_drop.id, 'TT5_14_091555');
%            testCase.assertInstanceOf(an_ascii_drop, 'ascii_drop');
%            testCase.assertNotEmpty(an_ascii_drop.pot.data);
%            testCase.assertNotEmpty(an_ascii_drop.accy.data);
%        end

        %function test_drop_flag(testCase)
        %    ascii_set = drop_set('resources/small_data/ascii/', 0, true, true);
        %    an_ascii_drop = ascii_set.drops(1).Value;
        %    testCase.assertEqual(an_ascii_drop.flagged, false);
        %    an_ascii_drop.flag();
        %    testCase.assertEqual(an_ascii_drop.flagged, true);
        %    testCase.assertEqual(an_ascii_drop.flagged, true);
        %    an_ascii_drop.unflag();
        %    testCase.assertEqual(an_ascii_drop.flagged, false);
        %end

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
