#! /bin/bash

sqlldr _name/_pass control=student.ctl
sqlldr _name/_pass control=template.ctl
sqlldr _name/_pass control=studentSchedule.ctl
sqlldr _name/_pass control=templateSchedule.ctl
sqlldr _name/_pass control=course.ctl
sqlldr _name/_pass control=prerequisite.ctl
sqlldr _name/_pass control=corequisite.ctl
sqlldr _name/_pass control=courseFulfills.ctl
sqlldr _name/_pass control=gradRequirement.ctl
sqlldr _name/_pass control=department.ctl
sqlldr _name/_pass control=major.ctl
sqlldr _name/_pass control=advisor.ctl
