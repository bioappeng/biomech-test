classdef unit_drop <  matlab.unittest.TestCase
    properties
        drop
    end

    methods(TestClassSetup)
        function class_setup_other(testCase)
            addpath('../../../lib/framework/');
        end
    end

    methods(TestMethodSetup)
        function setup_objects(testCase)
            testCase.drop = drop([], 'id', 0);
        end
    end

    methods(Test)
        function should_not_be_flagged_by_default(testCase)
            testCase.assertEqual(testCase.drop.flagged, false);
        end

        function change_flagged_should_flag_a_default_drop(testCase)
            testCase.drop.change_flagged();
            testCase.assertEqual(testCase.drop.flagged, true);
        end

        function change_flagged_should_unflag_a_flagged_drop(testCase)
            testCase.drop.flagged = true;
            testCase.drop.change_flagged();
            testCase.assertEqual(testCase.drop.flagged, false);
        end
    end
end
