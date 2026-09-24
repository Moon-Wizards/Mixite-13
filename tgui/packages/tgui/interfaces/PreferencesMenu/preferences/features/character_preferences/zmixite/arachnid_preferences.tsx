// THIS IS A MIXITE UI FILE
import {
  CheckboxInput,
  type Feature,
  type FeatureChoicedServerData,
  type FeatureToggle,
  FeatureTriColorInput,
  type FeatureValueProps,
} from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const arachnid_appendages_toggle: FeatureToggle = {
  name: 'Arachnid Appendages',
  component: CheckboxInput,
};

export const arachnid_appendages_color: Feature<string[]> = {
  name: 'Arachnid Appendages Colours',
  component: FeatureTriColorInput,
};

export const feature_arachnid_appendages: Feature<string> = {
  name: 'Arachnid Appendages Selection',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const arachnid_chelicerae_toggle: FeatureToggle = {
  name: 'Arachnid Chelicerae',
  component: CheckboxInput,
};

export const feature_arachnid_chelicerae: Feature<string> = {
  name: 'Arachnid Chelicerae Selection',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};
