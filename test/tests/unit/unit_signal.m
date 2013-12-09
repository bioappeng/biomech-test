classdef unit_signal < matlab.unittest.TestCase
    properties
        signal
    end

    methods(TestClassSetup)
        function class_setup_other(testCase)
            addpath('../../../lib/framework/');
        end
    end

    methods(TestMethodSetup)
        function setup_objects(testCase)
            testCase.signal = signal('a signal name', [1,2,3,4]);
        end
    end

    methods(Test)
        function should_not_be_flagged_by_default(testCase)
            testCase.assertEqual(testCase.signal.flagged, false);
        end

        function change_flagged_should_flag_a_default_signal(testCase)
            testCase.signal.change_flagged();
            testCase.assertEqual(testCase.signal.flagged, true);
        end

        function change_flagged_should_unflag_a_flagged_signal(testCase)
            testCase.signal.flagged = true;
            testCase.signal.change_flagged();
            testCase.assertEqual(testCase.signal.flagged, false);
        end
    end
end
