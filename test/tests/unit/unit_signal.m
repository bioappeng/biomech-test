classdef unit_signal < matlab.unittest.TestCase
    properties
        signal
    end

    methods(TestMethodSetup)
        function setup_objects(testCase)
            testCase.signal = signal('a signal name', [1,2,3,4]);
        end
    end

    methods(Test)
        function should_have_a_name(testCase)
            testCase.assertEqual(testCase.signal.name, 'a signal name');
        end

        function should_have_data(testCase)
            testCase.assertEqual(testCase.signal.data, [1,2,3,4]);
        end

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
