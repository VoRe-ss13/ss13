<<<<<<< HEAD
import { sortBy } from 'common/collections';
=======
import { useBackend } from 'tgui/backend';
import { Button, ColorBox, LabeledList, Section } from 'tgui-core/components';
>>>>>>> 116219bee6 ([MIRROR] Fixes the body designer [WIP] (#10105))

import { useBackend } from '../../backend';
import { Button, LabeledList, Section, Stack } from '../../components';
import { Data, species, styles } from './types';

export const AppearanceChangerSpecies = (props) => {
  const { act, data } = useBackend<Data>();
  const { species, specimen } = data;

  const sortedSpecies = sortBy(species || [], (val: species) => val.specimen);

  return (
    <Section title="Unique Identifiers" fill scrollable>
      <Section title="Species">
        {sortedSpecies.map((spec) => (
          <Button
            key={spec.specimen}
            selected={specimen === spec.specimen}
            onClick={() => act('race', { race: spec.specimen })}
          >
            {spec.specimen}
          </Button>
        ))}
      </Section>
      <Section title="DNA">
        <LabeledList>
          {data.is_design_console ? (
            <LabeledList.Item label="Character Name">
              <Button icon="pen" onClick={() => act('char_name')}>
                {data.name}
              </Button>
            </LabeledList.Item>
          ) : (
            ''
          )}
          <LabeledList.Item label="Custom Species Name">
            <Button icon="pen" onClick={() => act('race_name')}>
              {data.species_name ? data.species_name : specimen}
            </Button>
          </LabeledList.Item>
          <LabeledList.Item label="Species Appearance">
            <Button
              icon="pen"
              disabled={!data.use_custom_icon}
              onClick={() => act('base_icon')}
            >
              {data.base_icon ? data.base_icon : specimen}
            </Button>
          </LabeledList.Item>
          <LabeledList.Item label="Blood Reagent">
            <Button icon="pen" onClick={() => act('blood_reagent')}>
              {data.blood_reagent}
            </Button>
          </LabeledList.Item>
          <LabeledList.Item label="Blood Color">
            <Button icon="pen" onClick={() => act('blood_color')}>
              {data.blood_color}
            </Button>
            <ColorBox color={data.blood_color} mr={1} />
          </LabeledList.Item>
          <LabeledList.Item label="Digitigrade">
            <Button icon="pen" onClick={() => act('digitigrade')}>
              {data.digitigrade ? 'Yes' : 'No'}
            </Button>
          </LabeledList.Item>
          <LabeledList.Item label="Species Sound">
            <Button icon="pen" onClick={() => act('species_sound')}>
              {data.species_sound}
            </Button>
          </LabeledList.Item>
        </LabeledList>
      </Section>
      <Section title="Sizing">
        <LabeledList.Item label="Scale">
          <Button icon="pen" onClick={() => act('size_scale')}>
            {data.size_scale}
          </Button>
        </LabeledList.Item>
        <LabeledList.Item label="Scale Appearance">
          <Button icon="pen" onClick={() => act('scale_appearance')}>
            {data.scale_appearance}
          </Button>
        </LabeledList.Item>
        <LabeledList.Item label="Scale Offset">
          <Button icon="pen" onClick={() => act('offset_override')}>
            {data.offset_override}
          </Button>
        </LabeledList.Item>
        <LabeledList.Item label="Weight">
          <Button icon="pen" onClick={() => act('weight')}>
            {data.weight}
          </Button>
        </LabeledList.Item>
      </Section>
    </Section>
  );
};

export const AppearanceChangerGender = (props) => {
  const { act, data } = useBackend<Data>();

  const { gender, gender_id, genders, id_genders } = data;

  return (
    <Section title="Gender & Sex" fill scrollable>
      <LabeledList>
        <LabeledList.Item label="Biological Sex">
          {genders.map((g) => (
            <Button
              key={g.gender_key}
              selected={g.gender_key === gender}
              onClick={() => act('gender', { gender: g.gender_key })}
            >
              {g.gender_name}
            </Button>
          ))}
        </LabeledList.Item>
        <LabeledList.Item label="Gender Identity">
          {id_genders.map((g) => (
            <Button
              key={g.gender_key}
              disabled={data.is_design_console}
              selected={g.gender_key === gender_id}
              onClick={() => act('gender_id', { gender_id: g.gender_key })}
            >
              {g.gender_name}
            </Button>
          ))}
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};
<<<<<<< HEAD

export const AppearanceChangerEars = (props) => {
  const { act, data } = useBackend<Data>();

  const { ear_style, ear_styles } = data;

  return (
    <Stack vertical fill>
      <Stack.Item grow={1}>
        <Section title="Ears" fill scrollable>
          <Button
            onClick={() => act('ear', { clear: true })}
            selected={ear_style === null}
          >
            -- Not Set --
          </Button>
          {sortBy(ear_styles, (e: styles) => e.name.toLowerCase()).map(
            (ear) => (
              <Button
                key={ear.instance}
                onClick={() => act('ear', { ref: ear.instance })}
                selected={ear.name === ear_style}
              >
                {ear.name}
              </Button>
            ),
          )}
        </Section>
      </Stack.Item>
      <Stack.Item grow={1}>
        <Section title="Ears - Secondary" fill scrollable>
          <Button
            onClick={() => act('ear_secondary', { clear: true })}
            selected={data.ear_secondary_style === null}
          >
            -- Not Set --
          </Button>
          {sortBy(ear_styles, (e: styles) => e.name.toLowerCase()).map(
            (ear) => (
              <Button
                key={ear.instance}
                onClick={() => act('ear_secondary', { ref: ear.instance })}
                selected={ear.name === ear_style}
              >
                {ear.name}
              </Button>
            ),
          )}
        </Section>
      </Stack.Item>
    </Stack>
  );
};

export const AppearanceChangerTails = (props) => {
  const { act, data } = useBackend<Data>();

  const { tail_style, tail_styles } = data;

  return (
    <Section title="Tails" fill scrollable>
      <Button
        onClick={() => act('tail', { clear: true })}
        selected={tail_style === null}
      >
        -- Not Set --
      </Button>
      {sortBy(tail_styles, (e: styles) => e.name.toLowerCase()).map((tail) => (
        <Button
          key={tail.instance}
          onClick={() => act('tail', { ref: tail.instance })}
          selected={tail.name === tail_style}
        >
          {tail.name}
        </Button>
      ))}
    </Section>
  );
};

export const AppearanceChangerWings = (props) => {
  const { act, data } = useBackend<Data>();

  const { wing_style, wing_styles } = data;

  return (
    <Section title="Wings" fill scrollable>
      <Button
        onClick={() => act('wing', { clear: true })}
        selected={wing_style === null}
      >
        -- Not Set --
      </Button>
      {sortBy(wing_styles, (e: styles) => e.name.toLowerCase()).map((wing) => (
        <Button
          key={wing.instance}
          onClick={() => act('wing', { ref: wing.instance })}
          selected={wing.name === wing_style}
        >
          {wing.name}
        </Button>
      ))}
    </Section>
  );
};
=======
>>>>>>> 116219bee6 ([MIRROR] Fixes the body designer [WIP] (#10105))
