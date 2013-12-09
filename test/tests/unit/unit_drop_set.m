classdef unit_drop_set < matlab.unittest.TestCase
    methods(TestClassSetup)
        function class_setup_other(testCase)
            addpath('../../../lib/framework/');
        end
    end

    methods(Test)
        function get_drop_should_return_valid_and_correct_drop(testCase)
            drop1 = drop([], 'id', 0);
            drops(1).Value = drop1;
            a_drop_set = drop_set(drops);
            got_drop = a_drop_set.get_drop(1);
            testCase.assertEqual(got_drop, drop1);
        end

        function get_ids_should_return_cell_array_of_correct_drop_ids(testCase)
            addpath('../../mmockito/mmockito/');
            mock_drop1 = Mock();
            mock_drop2 = Mock();
            mock_drop3 = Mock();
            mock_drop1.when.get_id().thenReturn('one');
            mock_drop2.when.get_id().thenReturn('two');
            mock_drop3.when.get_id().thenReturn('three');
            drops(1).Value = mock_drop1;
            drops(2).Value = mock_drop2;
            drops(3).Value = mock_drop3;
            a_drop_set = drop_set(drops);
            ids = a_drop_set.drop_ids();
            testCase.assertEqual(ids, {'one', 'two', 'three'});
        end
    end
end
