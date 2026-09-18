El sistema está diseñado para gestionar la información de una entidad médica, relacionando médicos, empleados, pacientes, horarios, vacaciones y sustituciones.

La tabla principal es medico, donde se almacena la información de los médicos, como su identificación, nombre, apellidos, correo, teléfono, especialidad y consultorio.

La tabla paciente contiene los datos de los pacientes y tiene una relación con medico mediante medico_id. Esto significa que un médico puede tener varios pacientes, mientras que cada paciente está asociado a un médico.

La tabla empleado almacena los trabajadores del centro, como pueden ser ATS, celadores u otros puestos. Estos empleados pueden estar relacionados con sus vacaciones mediante la tabla vacaciones, donde se registra el estado y las fechas correspondientes.

La tabla horario permite registrar los horarios de atención. En el diagrama aparece relacionada tanto con el médico como con el empleado, por lo que se puede indicar quién realiza o está asociado a determinado horario.

Finalmente, la tabla sustitucion permite registrar las sustituciones que se realizan, relacionando al médico y al empleado que intervienen en ellas, además de información como el motivo y el estado
