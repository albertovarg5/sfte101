/**
 * PANDA 3D SOFTWARE
 * Copyright (c) Carnegie Mellon University.  All rights reserved.
 *
 * All use of this software is subject to the terms of the revised BSD
 * license.  You should have received a copy of this license along
 * with this source code in a file named "LICENSE."
 *
 * @file lvecBase3_ext_src.I
 * @author rdb
 * @date 2011-01-02
 */

#ifdef FLOATTYPE_IS_INT
#if PY_MAJOR_VERSION >= 3
#define PYNUMBER_FLOATTYPE PyNumber_Long
#define PY_AS_FLOATTYPE PyLong_AS_LONG
#else
#define PYNUMBER_FLOATTYPE PyNumber_Int
#define PY_AS_FLOATTYPE PyInt_AS_LONG
#endif
#else
#define PYNUMBER_FLOATTYPE PyNumber_Float
#define PY_AS_FLOATTYPE (FLOATTYPE)PyFloat_AsDouble
#endif

/**
 *
 */
INLINE_LINMATH std::string Extension<FLOATNAME(LVecBase3)>::
__repr__() const {
  char buf[128] = "LVecBase3";
  char *p = buf + strlen(buf);
  *(p++) = FLOATTOKEN;
  *(p++) = '(';
  FLOATTYPE_REPR(_this->_v(0), p);
  p += strlen(p);
  *(p++) = ',';
  *(p++) = ' ';
  FLOATTYPE_REPR(_this->_v(1), p);
  p += strlen(p);
  *(p++) = ',';
  *(p++) = ' ';
  FLOATTYPE_REPR(_this->_v(2), p);
  p += strlen(p);
  *(p++) = ')';
  *p = '\0';
  return std::string(buf, p - buf);
}

/**
 * This special Python method is implement to provide support for the pickle
 * module.
 */
INLINE_LINMATH PyObject *Extension<FLOATNAME(LVecBase3)>::
__reduce__(PyObject *self) const {
  // We should return at least a 2-tuple, (Class, (args)): the necessary class
  // object whose constructor we should call (e.g.  this), and the arguments
  // necessary to reconstruct this object.
  PyObject *this_class = PyObject_Type(self);
  if (this_class == nullptr) {
    return nullptr;
  }

#if FLOATTOKEN == 'i'
  PyObject *result = Py_BuildValue("(O(iii))", this_class,
                                   (*_this)[0], (*_this)[1], (*_this)[2]);
#elif FLOATTOKEN == 'f'
  PyObject *result = Py_BuildValue("(O(fff))", this_class,
                                   (*_this)[0], (*_this)[1], (*_this)[2]);
#else
  PyObject *result = Py_BuildValue("(O(ddd))", this_class,
                                   (*_this)[0], (*_this)[1], (*_this)[2]);
#endif

  Py_DECREF(this_class);
  return result;
}

/**
 * This is used to implement swizzle masks.
 */
INLINE_LINMATH PyObject *Extension<FLOATNAME(LVecBase3)>::
__getattr__(PyObject *self, const std::string &attr_name) const {
#ifndef CPPPARSER
  extern struct Dtool_PyTypedObject FLOATNAME(Dtool_LVecBase2);
  extern struct Dtool_PyTypedObject FLOATNAME(Dtool_LVecBase3);
  extern struct Dtool_PyTypedObject FLOATNAME(Dtool_LVecBase4);
#endif

  // Validate the attribute name.
  for (std::string::const_iterator it = attr_name.begin(); it < attr_name.end(); it++) {
    if (*it < 'x' || *it > 'z') {
      return Dtool_Raise_AttributeError(self, attr_name.c_str());
    }
  }

  switch (attr_name.size()) {
    case 1:
      return Dtool_WrapValue(_this->_v(attr_name[0] - 'x'));

    case 2: {
      FLOATNAME(LVecBase2) *vec = new FLOATNAME(LVecBase2);
      vec->_v(0) = _this->_v(attr_name[0] - 'x');
      vec->_v(1) = _this->_v(attr_name[1] - 'x');
      return DTool_CreatePyInstance((void *)vec, FLOATNAME(Dtool_LVecBase2), true, false);

    } case 3: {
      FLOATNAME(LVecBase3) *vec = new FLOATNAME(LVecBase3);
      vec->_v(0) = _this->_v(attr_name[0] - 'x');
      vec->_v(1) = _this->_v(attr_name[1] - 'x');
      vec->_v(2) = _this->_v(attr_name[2] - 'x');
      return DTool_CreatePyInstance((void *)vec, FLOATNAME(Dtool_LVecBase3), true, false);

    } case 4: {
      FLOATNAME(LVecBase4) *vec = new FLOATNAME(LVecBase4);
      vec->_v(0) = _this->_v(attr_name[0] - 'x');
      vec->_v(1) = _this->_v(attr_name[1] - 'x');
      vec->_v(2) = _this->_v(attr_name[2] - 'x');
      vec->_v(3) = _this->_v(attr_name[3] - 'x');
      return DTool_CreatePyInstance((void *)vec, FLOATNAME(Dtool_LVecBase4), true, false);
    }
  }

  return Dtool_Raise_AttributeError(self, attr_name.c_str());
}

/**
 * This is used to implement write masks.
 */
INLINE_LINMATH int Extension<FLOATNAME(LVecBase3)>::
__setattr__(PyObject *self, const std::string &attr_name, PyObject *assign) {
#ifndef NDEBUG
  // Validate the attribute name.
  for (std::string::const_iterator it = attr_name.begin(); it < attr_name.end(); it++) {
    if (*it < 'x' || *it > 'z') {
      Dtool_Raise_AttributeError(self, attr_name.c_str());
      return -1;
    }
  }
#endif

  // It is a sequence, perhaps another vector?
  if (PySequence_Check(assign)) {

    // Whoosh.
    PyObject* fast = PySequence_Fast(assign, "");
    nassertr(fast != nullptr, -1);

    // Let's be strict about size mismatches, to prevent user error.
    if (PySequence_Fast_GET_SIZE(fast) != (int)attr_name.size()) {
      PyErr_SetString(PyExc_ValueError, "length mismatch");
      Py_DECREF(fast);
      return -1;
    }

    // Get a pointer to the items, iterate over it and perform our magic
    // assignment.  Fast fast.  Oh yeah.
    PyObject** items = PySequence_Fast_ITEMS(fast);
    for (size_t i = 0; i < attr_name.size(); ++i) {

      PyObject* fl = PYNUMBER_FLOATTYPE(items[i]);
      if (fl == nullptr) {
        // Oh darn.  Not when we've come this far.
#ifdef FLOATTYPE_IS_INT
        PyErr_SetString(PyExc_ValueError, "a sequence of integers is required");
#else
        PyErr_SetString(PyExc_ValueError, "a sequence of floats is required");
#endif
        Py_DECREF(fast);
        return -1;
      }
      FLOATTYPE value = PY_AS_FLOATTYPE(fl);
      Py_DECREF(fl);

      _this->_v(attr_name[i] - 'x') = value;
    }

    Py_DECREF(fast);

  } else {
    // Maybe it's a single floating-point value.
    PyObject* fl = PYNUMBER_FLOATTYPE(assign);
    if (fl == nullptr) {
      // It's not a floating-point value either?  Sheesh, I don't know what to
      // do with it then.
      if (attr_name.size() == 1) {
#ifdef FLOATTYPE_IS_INT
        PyErr_SetString(PyExc_ValueError, "an integer is required");
#else
        PyErr_SetString(PyExc_ValueError, "a float is required");
#endif
      } else {
        PyErr_Format(PyExc_ValueError, "'%.200s' object is not iterable",
          Py_TYPE(assign)->tp_name);
      }
      return -1;
    }
    FLOATTYPE value = PY_AS_FLOATTYPE(fl);
    Py_DECREF(fl);

    // Loop through the components in the attribute name, and assign the
    // floating-point value to every one of them.
    for (std::string::const_iterator it = attr_name.begin(); it < attr_name.end(); it++) {
      _this->_v((*it) - 'x') = value;
    }
  }

  return 0;
}

/**
 *
 */
INLINE_LINMATH PyObject *Extension<FLOATNAME(LVecBase3)>::
__floordiv__(PyObject *self, FLOATTYPE scalar) const {
  if (scalar == (FLOATTYPE)0) {
    return PyErr_Format(PyExc_ZeroDivisionError, "floor division by zero");
  }

#ifndef CPPPARSER
  extern struct Dtool_PyTypedObject FLOATNAME(Dtool_LVecBase3);
#endif
  PyObject *py_vec = PyObject_CallNoArgs((PyObject *)DtoolInstance_TYPE(self));
  if (py_vec != nullptr) {
    FLOATNAME(LVecBase3) *vec = (FLOATNAME(LVecBase3) *)DtoolInstance_UPCAST(py_vec, FLOATNAME(Dtool_LVecBase3));
    nassertr(vec != nullptr, nullptr);

#ifdef FLOATTYPE_IS_INT
    if (scalar > 0) {
      vec->_v(0) = (_this->_v(0) >= 0) ? _this->_v(0) / scalar : -1 - (-1 - _this->_v(0)) / scalar;
      vec->_v(1) = (_this->_v(1) >= 0) ? _this->_v(1) / scalar : -1 - (-1 - _this->_v(1)) / scalar;
      vec->_v(2) = (_this->_v(2) >= 0) ? _this->_v(2) / scalar : -1 - (-1 - _this->_v(2)) / scalar;
    } else {
      vec->_v(0) = (_this->_v(0) <= 0) ? _this->_v(0) / scalar : -1 + (1 - _this->_v(0)) / -scalar;
      vec->_v(1) = (_this->_v(1) <= 0) ? _this->_v(1) / scalar : -1 + (1 - _this->_v(1)) / -scalar;
      vec->_v(2) = (_this->_v(2) <= 0) ? _this->_v(2) / scalar : -1 + (1 - _this->_v(2)) / -scalar;
    }
#else
    vec->_v(0) = std::floor(_this->_v(0) / scalar);
    vec->_v(1) = std::floor(_this->_v(1) / scalar);
    vec->_v(2) = std::floor(_this->_v(2) / scalar);
#endif
  }
  return py_vec;
}

/**
 *
 */
INLINE_LINMATH PyObject *Extension<FLOATNAME(LVecBase3)>::
__ifloordiv__(PyObject *self, FLOATTYPE scalar) {
  if (scalar == (FLOATTYPE)0) {
    return PyErr_Format(PyExc_ZeroDivisionError, "floor division by zero");
  }

#ifdef FLOATTYPE_IS_INT
  if (scalar > 0) {
    _this->_v(0) = (_this->_v(0) >= 0) ? _this->_v(0) / scalar : -1 - (-1 - _this->_v(0)) / scalar;
    _this->_v(1) = (_this->_v(1) >= 0) ? _this->_v(1) / scalar : -1 - (-1 - _this->_v(1)) / scalar;
    _this->_v(2) = (_this->_v(2) >= 0) ? _this->_v(2) / scalar : -1 - (-1 - _this->_v(2)) / scalar;
  } else {
    _this->_v(0) = (_this->_v(0) <= 0) ? _this->_v(0) / scalar : -1 + (1 - _this->_v(0)) / -scalar;
    _this->_v(1) = (_this->_v(1) <= 0) ? _this->_v(1) / scalar : -1 + (1 - _this->_v(1)) / -scalar;
    _this->_v(2) = (_this->_v(2) <= 0) ? _this->_v(2) / scalar : -1 + (1 - _this->_v(2)) / -scalar;
  }
#else
  _this->_v(0) = std::floor(_this->_v(0) / scalar);
  _this->_v(1) = std::floor(_this->_v(1) / scalar);
  _this->_v(2) = std::floor(_this->_v(2) / scalar);
#endif
  Py_INCREF(self);
  return self;
}

/**
 *
 */
INLINE_LINMATH PyObject *Extension<FLOATNAME(LVecBase3)>::
__pow__(PyObject *self, FLOATTYPE exponent) const {
#ifndef CPPPARSER
  extern struct Dtool_PyTypedObject FLOATNAME(Dtool_LVecBase3);
#endif
  PyObject *py_vec = PyObject_CallNoArgs((PyObject *)DtoolInstance_TYPE(self));
  if (py_vec != nullptr) {
    FLOATNAME(LVecBase3) *vec = (FLOATNAME(LVecBase3) *)DtoolInstance_UPCAST(py_vec, FLOATNAME(Dtool_LVecBase3));
    nassertr(vec != nullptr, nullptr);

    vec->_v(0) = cpow(_this->_v(0), exponent);
    vec->_v(1) = cpow(_this->_v(1), exponent);
    vec->_v(2) = cpow(_this->_v(2), exponent);
  }
  return py_vec;
}

/**
 *
 */
INLINE_LINMATH PyObject *Extension<FLOATNAME(LVecBase3)>::
__ipow__(PyObject *self, FLOATTYPE exponent) {
  _this->_v(0) = cpow(_this->_v(0), exponent);
  _this->_v(1) = cpow(_this->_v(1), exponent);
  _this->_v(2) = cpow(_this->_v(2), exponent);
  Py_INCREF(self);
  return self;
}

/**
 *
 */
INLINE_LINMATH PyObject *Extension<FLOATNAME(LVecBase3)>::
__round__(PyObject *self) const {
#ifndef CPPPARSER
  extern struct Dtool_PyTypedObject FLOATNAME(Dtool_LVecBase3);
#endif
  PyObject *py_vec = PyObject_CallNoArgs((PyObject *)DtoolInstance_TYPE(self));
  if (py_vec != nullptr) {
    FLOATNAME(LVecBase3) *vec = (FLOATNAME(LVecBase3) *)DtoolInstance_UPCAST(py_vec, FLOATNAME(Dtool_LVecBase3));
    nassertr(vec != nullptr, nullptr);

    vec->_v(0) = std::round(_this->_v(0));
    vec->_v(1) = std::round(_this->_v(1));
    vec->_v(2) = std::round(_this->_v(2));
  }
  return py_vec;
}

/**
 *
 */
INLINE_LINMATH PyObject *Extension<FLOATNAME(LVecBase3)>::
__floor__(PyObject *self) const {
#ifndef CPPPARSER
  extern struct Dtool_PyTypedObject FLOATNAME(Dtool_LVecBase3);
#endif
  PyObject *py_vec = PyObject_CallNoArgs((PyObject *)DtoolInstance_TYPE(self));
  if (py_vec != nullptr) {
    FLOATNAME(LVecBase3) *vec = (FLOATNAME(LVecBase3) *)DtoolInstance_UPCAST(py_vec, FLOATNAME(Dtool_LVecBase3));
    nassertr(vec != nullptr, nullptr);

    vec->_v(0) = std::floor(_this->_v(0));
    vec->_v(1) = std::floor(_this->_v(1));
    vec->_v(2) = std::floor(_this->_v(2));
  }
  return py_vec;
}

/**
 *
 */
INLINE_LINMATH PyObject *Extension<FLOATNAME(LVecBase3)>::
__ceil__(PyObject *self) const {
#ifndef CPPPARSER
  extern struct Dtool_PyTypedObject FLOATNAME(Dtool_LVecBase3);
#endif
  PyObject *py_vec = PyObject_CallNoArgs((PyObject *)DtoolInstance_TYPE(self));
  if (py_vec != nullptr) {
    FLOATNAME(LVecBase3) *vec = (FLOATNAME(LVecBase3) *)DtoolInstance_UPCAST(py_vec, FLOATNAME(Dtool_LVecBase3));
    nassertr(vec != nullptr, nullptr);

    vec->_v(0) = std::ceil(_this->_v(0));
    vec->_v(1) = std::ceil(_this->_v(1));
    vec->_v(2) = std::ceil(_this->_v(2));
  }
  return py_vec;
}

#undef PYNUMBER_FLOATTYPE
#undef PY_AS_FLOATTYPE
#undef FLOATTYPE_TO_STR
